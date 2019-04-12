require 'singleton'

module Modl::Parser
  class ClassProcessor

    include Singleton

    def process global, obj

      if obj.is_a? Array
        obj.each {|o| process_obj global, o if o.is_a? Hash}
      elsif obj.is_a? Hash
        process_obj global, obj
      end
    end

    def process_obj global, obj
      obj.keys.each do |k|
        value = obj[k]
        clazz = global.classes[k]

        if clazz
          new_k, new_v = process_class global, k, value
          obj.delete k
          obj[new_k] = new_v
        end

        process global, value
      end
    end

    def process_class(global, k, v)
      clazz = global.classes[k]

      new_value = {}
      clazz_keys = clazz.keys
      clazz_keys.each do |clazz_key|
        case clazz_key
        when 'keylist'
          key_list = clazz['keylist']
          keys = nil
          key_list.each do |kl|
            if kl.length == v.length
              keys = kl
              break
            end
          end
          if keys
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


      if v.is_a?(Array)
        v.each do |value|
          if value && value.is_a?(Hash)
            value.keys.each do |vk|
              new_value[vk] = value[vk]
            end
          end
        end
        new_value = v if new_value.empty?
      else
        tc = top_class(clazz, global)
        if tc == 'str'
          new_value = v.to_s
        elsif tc == 'num' && !v.is_a?(Numeric)
          raise Antlr4::Runtime::ParseCancellationException, 'Superclass of "' + clazz['id'] + '" is num - cannot assign String value "' + v.to_s + '"'
        elsif tc == 'map'
          if v.is_a? Hash
            new_value = v.merge(new_value)
            super_class = clazz['superclass']
            while true
              next_class = global.classes[super_class]
              break if next_class.nil?
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
            end
          else
            new_value[k] = v
          end
        else
          new_value = v
        end
      end

      if new_value.is_a? Hash
        new_value.keys.each do |nk|
          clazz2 = global.classes[nk]
          nv = new_value[nk]
          if clazz2
            if !nv.nil? && !nv.is_a?(String) && !nv.is_a?(Numeric)
              new_k, new_v = process_class global, nk, nv
            else
              new_k = (clazz2['name'].nil?) ? clazz2['id'] : clazz2['name']
              new_v = nv
            end

            if new_value[new_k] != new_v
              new_value.delete nk
              new_value[new_k] = new_v
            end
          end
        end
      end
      [clazz['name'], new_value]
    end

    def top_class clazz, global
      superclass = clazz['superclass']
      if superclass
        c = global.classes[superclass]
        if c
          return top_class(c, global)
        else
          return superclass
        end
      else
        # superclass is assumed
      end
    end
  end
end