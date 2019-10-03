# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright (c) 2019 NUM Technology Ltd
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module MODL
  module Parser
    # This class handles the conversion of objects that refer to classes into instances of those classes.
    # It works recursively since class usage can be nested.
    class ClassProcessor
      # How deep can the class structure be?
      MAX_RECURSION_DEPTH = 50
      # global is a GlobalParseContext and obj is the extracted Array or Hash from MODL::Parser::Parsed.extract_json
      def self.process(global, obj)
        # Process each object in the array or just process the object if its a hash.
        # Any other object is ignored.
        raise StandardError, 'parameter "global" should be a GlobalParseContext' unless global.is_a?(GlobalParseContext)

        if obj.is_a? Array
          obj.each do |o|
            process_obj global, o if o.is_a? Hash
          end
        elsif obj.is_a? Hash
          process_obj global, obj
        end
      end

      private

      # Process the contents of the supplied hash obj
      def self.process_obj(global, obj)
        obj.keys.each do |k|
          value = obj[k]
          # Does the key refer to a class that we have parsed or loaded?
          clazz = global.classs(k)
          if clazz
            # Yes so convert this value to an instance of that class
            new_k, new_v = process_class global, k, value
            # Replace the existing object with the new class instance and a new key
            # We need to keep the same key order, hence this method below
            replace_value(obj, k, new_k, new_v)
          else
            new_v = value
          end
          # Recurse into the value in case it has contents that also refer to classes.
          process global, new_v
        end
      end

      def self.replace_value(obj, old_k, new_k, new_v)
        tmp = obj.dup
        obj.clear
        tmp.keys.each do |tmpk|
          tmpv = tmp[tmpk]
          if tmpk == old_k
            obj[new_k] = new_v
          else
            obj[tmpk] = tmpv
          end
        end
      end

      def self.has_assign_statement?(clazz, global, depth = 0)
        # Check for *assign statements
        return if depth > MAX_RECURSION_DEPTH
        return nil? if clazz.nil?
        return true unless clazz.assign.nil?

        superclass = clazz.superclass
        c = global.classs(superclass)
        return has_assign_statement?(c, global, depth + 1) if c

        false
      end

      def self.has_inherited_pairs?(clazz, global, depth = 0)
        # Check for *assign statements
        return if depth > MAX_RECURSION_DEPTH
        return nil? if clazz.nil?
        return true unless clazz.content.empty?

        superclass = clazz.superclass
        c = global.classs(superclass)
        return has_inherited_pairs?(c, global, depth + 1) if c

        false
      end

      def self.process_class(global, k, v)
        clazz = global.classs(k)
        if k != clazz.id && !(v.is_a?(Hash) || v.is_a?(Array))
          return [k, v]
        end

        if k == clazz.name && !(v.is_a?(Array) || v.is_a?(Hash))
          new_value = transform_to_class(clazz, global, [v], true)
          if new_value.is_a?(Array) && new_value.length == 1
            return [clazz.name_or_id, new_value[0]]
          else
            return [clazz.name_or_id, new_value]
          end
        end

        new_value = transform_to_class(clazz, global, v)

        if v.is_a?(Array)
          new_value = v if new_value.empty?
        elsif v.is_a?(String)
          # Safe to ignore
        else
          # Safe to ignore
        end

        # Check the top class and do some type-specific processing
        tc = top_class(clazz, global)
        if tc.nil?
          # There is no defined top class so we need to infer it base on the value
          # and the rules defined here: https://github.com/MODLanguage/grammar/wiki/Class-Supertype-Processing
          #
          if has_assign_statement?(clazz, global)
            tc = 'map'
          else
            if has_inherited_pairs?(clazz, global)
              tc = 'map'
            else
              if v.is_a? String
                tc = 'str'
              elsif v.is_a? Numeric
                tc = 'num'
              elsif (v.is_a? TrueClass) || (v.is_a? FalseClass)
                tc = 'bool'
              elsif v.nil?
                tc = 'null'
              elsif v.is_a? Array
                tc = 'arr'
              elsif v.is_a? Hash
                tc = 'map'
              end
            end
          end
        end
        if tc == 'str'
          raise InterpreterError, "Interpreter Error: Cannot convert null value to string." if v.nil?
          new_value = v.to_s
        elsif tc == 'num'
          if (v.is_a? String) && (v.to_i.to_s == v.to_s)
            new_value = v.to_i
          elsif (v.is_a? String) && (v.to_f.to_s == v.to_s)
            new_value = v.to_f
          elsif v.is_a? TrueClass
            new_value = 1
          elsif v.is_a? FalseClass
            new_value = 0
          elsif v.is_a? Numeric
            new_value = v
          else
            raise InterpreterError, 'Superclass of "' + clazz.id + '" is num - cannot assign value "' + v.to_s + '"'
          end
        elsif tc == 'bool'
          new_value = v
        elsif tc == 'null'
          new_value = nil
        elsif tc == 'arr'
          if v.is_a? Array
            new_value = v
          elsif v.is_a? Hash
            raise InterpreterError, 'Interpreter Error: Cannot convert map to array: ' + v.to_s
          else
            new_value = [v]
          end
        elsif tc == 'map'
          if new_value.is_a? Hash
            # Bring down values from the superclass hierarchy
            new_value = copy_from_superclasses(clazz, global, new_value, v)
          elsif v.is_a? Array
            raise InterpreterError, 'Interpreter Error: Cannot convert array to map: ' + v.to_s
          else
            new_value = {}
            new_value['value'] = v
            # Bring down values from the superclass hierarchy
            new_value = copy_from_superclasses(clazz, global, new_value, v)
          end
        elsif tc.nil? && (v.is_a? Hash)
          new_value = v
        end

        [clazz.name_or_id, new_value]
      end

      # Bring down values from the superclass hierarchy
      def self.copy_from_superclasses(clazz, global, new_value, v)
        if v.is_a? Hash
          new_value = v.merge(new_value)
        end

        clazz.merge_content(new_value)

        depth = 0
        loop do
          clazz = global.classs(clazz.superclass)
          break if clazz.nil? || depth > MAX_RECURSION_DEPTH

          clazz.merge_content(new_value)
          depth += 1
        end
        new_value
      end

      # Transfer the keys from val to the new_value object.
      def self.copy_keys_to_new_value(new_value, val)
        val.each do |value|
          next unless value&.is_a?(Hash)

          new_value.merge!(value)
        end
      end

      # If the new_value has nested class references then process those recursively as well.
      def self.process_nested_classes(global, new_value)
        if new_value.is_a?(Hash)

          new_value.keys.each do |nk|
            clazz = global.classs(nk)
            nv = new_value[nk]
            next unless clazz # skip it if it doesn't refer to a class

            if !nv.nil? && !nv.is_a?(String) && !nv.is_a?(Numeric)
              new_k, new_v = process_class global, nk, nv
            else
              new_k = clazz.name_or_id
              new_v = nv
            end

            # Replace the value for this key if we've changed anything.
            if new_value[new_k] != new_v
              replace_value(new_value, new_k, new_k, new_v)
            end
          end
        elsif new_value.is_a?(Array)
          new_value.each do |nk|
            process_nested_classes(global, nk)
          end
        end
      end

      # Process the *assign lists ('keylist' in this code) and any extra pairs defined by the class.
      # The id, name, and superclass can be ignored here.
      def self.transform_to_class(clazz, global, v, ignore_assign = false)
        new_value = {} # the replacement for val after conversion to a class instance
        process_nested_classes(global, v)

        # Process the key list if we found one otherwise raise an error
        # Slightly different processing for hashes and arrays
        unless ignore_assign
          if v.is_a? Array
            keys = key_list(global, clazz, v.length)
            if keys.empty?
              return v
            else
              lam = ->(i) {v[i]}
            end
          elsif !v.is_a?(Hash)
            keys = key_list(global, clazz, 1)
            lam = ->(i) {v}
            return v if keys.length.zero?
          end
        end

        keys&.each_index do |i|
          new_value[keys[i]] = lam.call(i)
        end

        new_value.keys do |nk|
          process_obj global, new_value[nk]
        end

        clazz.merge_content(new_value)
      end

      def self.key_list(global, clazz, len)
        return [] if clazz.nil?
        list = clazz.keylist_of_length(len)
        return list if !list.nil? && list.length > 0
        superclass = global.classs(clazz.superclass)
        key_list(global, superclass, len)
      end

      # Get the top level class for the supplied class
      def self.top_class(clazz, global, depth = 0)
        # Check for self-referential classes that cause infinite recursion
        return if depth > MAX_RECURSION_DEPTH
        return nil? if clazz.nil?

        superclass = clazz.superclass
        c = global.classs(superclass)
        return top_class(c, global, depth + 1) if c

        superclass
      end
    end
  end
end
