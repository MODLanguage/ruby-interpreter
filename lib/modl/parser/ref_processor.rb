require 'singleton'
require 'modl/parser/parsed'

module Modl::Parser
  class RefProcessor

    include Singleton

    def deref str, global

      count = str.count('%')
      while count > 0
        str, new_value = split_by_ref_tokens str, global
        count -= 1
      end
      [str, new_value]
    end

    def split_by_ref_tokens str, global
      parts = []
      idx = str.index '`%'
      if idx.nil?
        idx = str.index '%'
        return [str, nil] if idx.nil?
        graved = false
      else
        graved = true
      end

      parts << str.slice(0, idx)
      skip = (graved) ? 2 : 1

      parts << str.slice(idx + skip, str.length)

      # Are there any methods?
      dot_index = parts[1].index('.')
      grave_index = parts[1].index('`')
      if grave_index.nil?
        grave_index = parts[1].length
      end
      if dot_index && (dot_index < grave_index)
        method_str = parts[1].slice(dot_index, parts[1].length)
      end
      # Handle nested refs
      if parts[1].include? '>'
        ref_key = parts[1].slice(0, parts[1].index('>'))

        num_ref_key = ref_key.to_i
        if num_ref_key.to_s == ref_key
          new_value = nested_value(parts[1].slice(parts[1].index('>') + 1, parts[1].length), global.index[num_ref_key], global)
        else
          new_value = nested_value(parts[1].slice(parts[1].index('>') + 1, parts[1].length), global.pairs[ref_key], global)
        end

        if new_value
          tmp = parts[1]
          if new_value.is_a?(Fixnum)
            parts[1] = new_value
          elsif new_value.is_a? String
            parts[1] = new_value
          else
            txt_value = new_value.extract_hash
            parts[1] = txt_value
          end
          parts[2] = tmp.slice(tmp.index('`'), tmp.length) if graved
          new_value = nil
        end
      else
        # Check for a numeric key
        key = ''
        while parts[1].length > 0 && is_digit(parts[1][0])
          key << parts[1][0]
          parts[1] = parts[1].slice(1, parts[1].length)
        end

        if key.length > 0
          index = key.to_i
          tmp = parts[1]
          if index < global.index.length
            index_val = global.index[index]
            if index_val.is_a?(Fixnum) || index_val.is_a?(String)
              parts[1] = index_val
            else
              parts[1] = index_val.extract_hash
            end
            parts << tmp
          else
            if key.length > 0
              parts[1] = '%' + key
            else
              parts[1] = '%' + parts[1]
              parts[1].sub!('`', '') if graved
            end
          end
        else
          #no numeric key so try a text key
          best_match = ''

          global.pairs.keys.each do |k|
            if parts[1].start_with?(k) && k.length > best_match.length
              best_match = k
            end
          end

          if best_match.length > 0
            tmp = parts[1]
            parts[1] = global.pairs[best_match].text
            parts[2] = tmp.slice(best_match.length, tmp.length)
            if str.start_with?('`%') || str.start_with?('%')
              pair = global.pairs[best_match]
              if pair.array
                new_value = pair.array
                parts[1] = new_value.extract_hash
              end
            end
          else
            if key.length > 0
              parts[1] = '%' + key
            else
              parts[1] = '%' + parts[1]
              parts[1].sub!('`', '') if graved
            end
          end
        end
      end

      # Are there any methods to run?
      next_part = 2
      remainder = method_str
      while parts.length == 3 && remainder && remainder[0] == '.'
        method, remainder = get_method remainder

        case method
        when '.u'
          parts[1] = parts[1].upcase
          parts[next_part] = parts[next_part].slice(2, parts[next_part].length) if parts[next_part].start_with? method
        when '.d'
          parts[1] = parts[1].downcase
          parts[next_part] = parts[next_part].slice(2, parts[next_part].length) if parts[next_part].start_with? method
        when '.i'
          parts[1] = parts[1].split.map(&:capitalize) * ' '
          parts[next_part] = parts[next_part].slice(2, parts[next_part].length) if parts[next_part].start_with? method
        when '.s'
          split = parts[1].split
          split[0].capitalize!
          parts[1] = split.join(' ')
          parts[next_part] = parts[next_part].slice(2, parts[next_part].length) if parts[next_part].start_with? method
        when '.e'
          parts[1] = CGI.escape(parts[1])
          parts[next_part] = parts[next_part].slice(2, parts[next_part].length) if parts[next_part].start_with? method
        when '.r'
          s1, s2 = get_subst_parts parts[next_part]
          parts[1] = parts[1].sub(s1, s2)
          # Consume the subst clause
          close_bracket = parts[next_part].index(')')
          parts[next_part] = parts[next_part].slice(close_bracket + 1, parts[next_part].length)
        when '.t'
          s1 = get_trunc_part parts[next_part]
          i = parts[1].index(s1)
          parts[1] = parts[1].slice(0, i)
          # Consume the trunc clause
          close_bracket = parts[next_part].index(')')
          parts[next_part] = parts[next_part].slice(close_bracket + 1, parts[next_part].length)
        else
          # Check for user-defined methods and execute them
          if method
            m = global.methods_hash[method.slice(1, method.length)]

            if m
              parts[1] = run_method m['transform'], parts[1]
              parts[next_part] = ''
            else
              parts[next_part] = method
              next_part += 1
              parts[next_part] = remainder
            end
          end
        end

      end
      parts[next_part] = parts[next_part].slice(1, parts[next_part].length) if graved && parts[next_part]

      # Join the parts and return the result.
      if parts[0].empty? && parts[2] && parts[2].empty?
        [parts[1], new_value]
      elsif parts[0].empty? && !(parts[2])
        [parts[1], new_value]
      elsif !parts[0].empty? || !(parts[2] && parts[2].empty?)
        [parts.join, new_value]
      else
        [parts[1], new_value]
      end
    end

    def nested_value ref, value, global
      if ref.start_with? '%'
        ref, new_value = RefProcessor.instance.deref ref, global
      end
      unless ref.include? '>'
        if value.is_a? Parsed::ParsedPair
          if value.valueItem && value.valueItem.value.value_obj.is_a?(Parsed::ParsedPair)
            return value.valueItem.value.value_obj.valueItem.value.value_obj
          elsif value.map
            map_hash = value.map.extract_hash
            return map_hash[ref]
          end
        elsif value.is_a? Parsed::ParsedArrayValueItem
          num_ref = ref.to_i
          return value.array.abstractArrayItems[num_ref]
        elsif value.is_a? Parsed::ParsedArrayItem
          num_ref = ref.to_i
          return value.arrayValueItem.array.abstractArrayItems[num_ref] if value.arrayValueItem.array
          return value.arrayValueItem.text+'>'+ref
        elsif value.is_a? Parsed::ParsedNbArray
          num_ref = ref.to_i
          return value.arrayItems[num_ref]
        end
        ref_key = ref
      else
        end_index = ref.index('`')
        if end_index.nil?
          end_index = ref.length
        end
        gt_index = ref.index('>')
        if gt_index < end_index
          ref_key = ref.slice(0, gt_index)
          remainder = ref.slice(gt_index + 1, ref.length)
        else
          ref_key = ref.slice(0, end_index)
        end
      end

      if ref_key.include?('`')
        g_index = ref_key.index('`')
        ref_key = ref_key.slice(0, g_index)
      end

      if ref_key.include?('.')
        dot_index = ref_key.index('.')
        ref_key = ref_key.slice(0, dot_index)
      end

      if value.map
        the_map = value.map
      elsif value.methods.include?(:valueItem) && value.valueItem && value.valueItem.value.map
        the_map = value.valueItem.value.map
      elsif value.array
        the_array = value.array
      elsif value.valueItem.value.array
        the_array = value.valueItem.value.array
      elsif value.valueItem.value.nbArray
        the_nbarray = value.valueItem.value.nbArray
      end

      target_key = nil
      the_pair = nil

      if the_map
        map_items = the_map.mapItems
        map_items.each do |item|
          if ref_key == item.pair.key
            the_pair = item.pair
            target_key = ref_key
          end
        end
      elsif the_array
        result = the_array.abstractArrayItems[ref_key.to_i]
        if remainder && remainder.length > 0
          return nested_value(remainder, result, global)
        else
          return result
        end
      elsif the_nbarray
        result = the_nbarray.arrayItems[ref_key.to_i]
        if remainder && remainder.length > 0
          return nested_value(remainder, result.arrayValueItem, global)
        else
          return result
        end
      else
        the_pair = value.valueItem.value.pair
        if the_pair
          target_key = the_pair.key
        end
      end

      if ref_key == target_key
        result = the_pair
        if remainder && remainder.length > 0
          return nested_value(remainder, result, global)
        else
          return result.valueItem
        end
      else
        raise Antlr4::Runtime::ParseCancellationException, ref_key + ' item not found for reference ' + ref
      end
    end

    def get_subst_parts(s)
      # should be of the form .r(s1,s2)
      open_bracket = s.index '('
      close_bracket = s.index ')'
      s.slice(open_bracket + 1, close_bracket - open_bracket - 1).split(',')
    end

    def get_trunc_part(s)
      # should be of the form .r(s1,s2)
      open_bracket = s.index '('
      close_bracket = s.index ')'
      s.slice(open_bracket + 1, close_bracket - open_bracket - 1)
    end

    def get_method(str)
      one_char_method_name = (str.length == 2 || (str.length > 2 && !is_alpha(str[2])))
      if one_char_method_name
        'udisert'.each_char do |m|
          method_name = '.' + m
          if str.start_with?(method_name)
            remainder = str.slice(2, str.length)
            return [method_name, remainder]
          end
        end
        return
      else
        # longer name - possibly a method
        method_name = '.'
        i = 1
        while i < str.length && is_alpha(str[i])
          method_name << str[i]
          i += 1
        end

        if method_name.length > 1
          remainder = str.slice(method_name.length + 1, str.length)
          return [method_name, remainder]
        end
      end
    end

    def is_digit c
      cp = c.codepoints[0]
      (cp >= 48) && (cp <= 57)
    end

    def is_alpha s
      c = s.codepoints[0]
      return false if c < 65
      return false if c > 122
      return false if c > 90 && c < 97
      true
    end

    def run_method(transform, str)
      while transform && transform.length > 0
        if transform.start_with? 'replace'
          s1, s2 = get_subst_parts transform
          s2 = '' if s2.nil?
          str = str.sub(s1, s2)
          # Consume the subst clause
          close_bracket = transform.index(')')
          transform = transform.slice(close_bracket + 2, transform.length)
        elsif transform.start_with? 'trim'
          s1 = get_trunc_part transform
          i = str.index(s1)
          str = str.slice(0, i)
          # Consume the trunc clause
          close_bracket = transform.index(')')
          transform = transform.slice(close_bracket + 2, transform.length)
        elsif transform.start_with? 'initcap'
          str = str.split.map(&:capitalize) * ' '
          transform = transform.slice(8, transform.length)
        elsif transform.start_with? 'upcase'
          raise Antlr4::Runtime::ParseCancellationException, 'NOT IMPLEMENTED'
        elsif transform.start_with? 'downcase'
          raise Antlr4::Runtime::ParseCancellationException, 'NOT IMPLEMENTED'
        elsif transform.start_with? 'sentence'
          raise Antlr4::Runtime::ParseCancellationException, 'NOT IMPLEMENTED'
        elsif transform.start_with? 'urlencode'
          raise Antlr4::Runtime::ParseCancellationException, 'NOT IMPLEMENTED'
        else
          raise Antlr4::Runtime::ParseCancellationException, 'NOT IMPLEMENTED'
        end
      end
      str
    end
  end
end