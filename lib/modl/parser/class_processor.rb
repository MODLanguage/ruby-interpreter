require 'singleton'

module Modl
  module Parser
    # This class handles the conversion of objects that refer to classes into instances of those classes.
    # It works recursively since class usage can be nested.
    class ClassProcessor
      include Singleton
      # How deep can the class structure be?
      MAX_RECURSION_DEPTH = 20
      # global is a GlobalParseContext and obj is the extracted Array or Hash from Modl::Parser::Parsed.extract_json
      def process(global, obj)
        # Process each object in the array or just process the object if its a hash.
        # Any other object is ignored.
        raise StandardError, 'parameter "global" should be a GlobalParseContext' unless global.is_a?(GlobalParseContext)

        if obj.is_a? Array
          obj.each {|o| process_obj global, o if o.is_a? Hash}
        elsif obj.is_a? Hash
          process_obj global, obj
        end
      end

      private

      # Process the contents of the supplied hash obj
      def process_obj(global, obj)
        obj.keys.each do |k|
          value = obj[k]
          # Does the key refer to a class that we have parsed or loaded?
          clazz = global.classes[k]
          if clazz
            # Yes so convert this value to an instance of that class
            new_k, new_v = process_class global, k, value
            # Replace the existing object with the new class instance
            obj.delete k
            obj[new_k] = new_v
          end
          # Recurse into the value in case it has contents that also refer to classes.
          process global, value
        end
      end

      # Convert the supplied object val into an instance of the class with key k
      def process_class(global, k, v)
        clazz = global.classes[k]
        new_value = transform_to_class(clazz, global, v)

        if v.is_a?(Array)
          copy_keys_to_new_value(new_value, v)
          new_value = v if new_value.empty?
        else
          # Check the top class and do some type-specific processing
          tc = top_class(clazz, global)
          if tc == 'str'
            new_value = v.to_s
          elsif tc == 'num' && !v.is_a?(Numeric)
            raise Antlr4::Runtime::ParseCancellationException, 'Superclass of "' + clazz['id'] + '" is num - cannot assign String value "' + v.to_s + '"'
          elsif tc == 'map'
            if v.is_a? Hash
              # Bring down values from the superclass hierarchy
              new_value = copy_from_superclasses(clazz, global, new_value, v)
            else
              new_value[k] = v
            end
          else
            new_value = v
          end
        end

        process_nested_classes(global, new_value)
        [clazz['name'], new_value]
      end

      # Bring down values from the superclass hierarchy
      def copy_from_superclasses(clazz, global, new_value, v)
        new_value = v.merge(new_value)
        super_class = clazz['superclass']
        depth = 0
        loop do
          next_class = global.classes[super_class]
          break if next_class.nil? || depth > MAX_RECURSION_DEPTH

          # Process the non-keyword values specified by the superclass
          next_class.keys.each do |nck|
            case nck
            when 'id'
            when 'name'
            when 'superclass'
            when 'keylist'
            else
              new_value[nck] = next_class[nck].extract_hash
            end
          end
          super_class = next_class['superclass']
          depth += 1
        end
        new_value
      end

      # Transfer the keys from val to the new_value object.
      def copy_keys_to_new_value(new_value, val)
        val.each do |value|
          next unless value&.is_a?(Hash)

          value.keys.each do |vk|
            new_value[vk] = value[vk]
          end
        end
      end

      # If the new_value has nested class references then process those recursively as well.
      def process_nested_classes(global, new_value)
        return unless new_value.is_a? Hash

        new_value.keys.each do |nk|
          clazz2 = global.classes[nk]
          nv = new_value[nk]
          next unless clazz2 # skip it if it doesn't refer to a class

          if !nv.nil? && !nv.is_a?(String) && !nv.is_a?(Numeric)
            new_k, new_v = process_class global, nk, nv
          else
            new_k = clazz2['name'].nil? ? clazz2['id'] : clazz2['name']
            new_v = nv
          end

          # Replace the value for this key if we've changed anything.
          if new_value[new_k] != new_v
            new_value.delete nk
            new_value[new_k] = new_v
          end
        end
      end

      # Process the *assign lists ('keylist' in this code) and any extra pairs defined by the class.
      # The id, name, and superclass can be ignored here.
      def transform_to_class(clazz, global, v)
        new_value = {} # the replacement for val after conversion to a class instance

        clazz_keys = clazz.keys

        # Process the keylist if we can find a matching one, ignore id, name, and superclass, and add anything else
        # to the new_value object.
        clazz_keys.each do |clazz_key|
          case clazz_key
          when 'keylist'
            key_list = clazz['keylist']
            keys = nil

            # Find a keylist of the right length from the *assign array of arrays.
            key_list.each do |kl|
              if kl.length == v.length
                keys = kl
                break
              end
            end
            # Process the key list if we found one otherwise raise an error
            if keys
              # Slightly different processing for hashes and arrays
              if v.is_a? Hash
                keys.each_index do |i|
                  new_value[keys[i]] = v[v.keys[i]]
                end
              elsif v.is_a? Array
                keys.each_index do |i|
                  new_value[keys[i]] = v[i]
                end
              end
            else
              raise Antlr4::Runtime::ParseCancellationException, 'No key list of the correct length in class ' + clazz['id'] + ' - looking for one of length ' + v.length.to_s if v.is_a? Array
            end
            new_value.keys do |nk|
              process_obj global, new_value[nk]
            end
          when 'id'
          when 'name'
          when 'superclass'
          else
            new_value[clazz_key] = clazz[clazz_key].extract_hash
          end
        end
        new_value
      end

      # Get the top level class for the supplied class
      def top_class clazz, global, depth = 0
        # Check for self-referential classes that cause infinite recursion
        return if depth > MAX_RECURSION_DEPTH

        superclass = clazz['superclass']
        c = global.classes[superclass]
        return top_class(c, global, depth + 1) if c

        superclass
        # else superclass is assumed
      end
    end
  end
end
