require 'singleton'
require 'modl/parser/parsed'

module Modl::Parser
  class RefProcessor

    include Singleton

    def deref str, values_array, pairs_hash

      puts 'De-reffing: ' + str
      count = str.count('%')
      while count > 0
        str, new_value = split_by_ref_tokens str, values_array, pairs_hash
        count -= 1
      end
      puts 'De-reffing result: ' + str + ', new_value = ' + new_value.to_s
      [str, new_value]
    end

    def split_by_ref_tokens str, values_array, pairs_hash
      parts = []
      idx = str.index '`%'
      if idx.nil?
        idx = str.index '%'
        graved = false
      else
        graved = true
      end

      parts << str.slice(0, idx)
      skip = (graved) ? 2 : 1

      parts << str.slice(idx + skip, str.length)

      # Check for a numeric key
      key = ''
      while parts[1].length > 0 && is_digit(parts[1][0])
        key << parts[1][0]
        parts[1] = parts[1].slice(1, parts[1].length)
      end

      if key.length > 0
        index = key.to_i
        tmp = parts[1]
        if index < values_array.length
          parts[1] = values_array[index].extract_hash
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

        pairs_hash.keys.each do |k|
          if parts[1].start_with?(k) && k.length > best_match.length
            best_match = k
          end
        end

        if best_match.length > 0
          tmp = parts[1]
          parts[1] = pairs_hash[best_match].text
          parts[2] = tmp.slice(best_match.length, tmp.length)
          new_value = pairs_hash[best_match] if str.start_with?('`%') || str.start_with?('%')
        else
          if key.length > 0
            parts[1] = '%' + key
          else
            parts[1] = '%' + parts[1]
            parts[1].sub!('`', '') if graved
          end
        end

      end

      # Are there any methods to run?
      next_part = 2
      while parts.length == 3 && parts[next_part][0] == '.'
        method, remainder = get_method parts[next_part]

        case method
        when '.u'
          parts[1] = parts[1].upcase
          parts[next_part] = parts[next_part].slice(2, parts[next_part].length)
        when '.d'
          parts[1] = parts[1].downcase
          parts[next_part] = parts[next_part].slice(2, parts[next_part].length)
        when '.i'
          parts[1] = parts[1].split.map(&:capitalize) * ' '
          parts[next_part] = parts[next_part].slice(2, parts[next_part].length)
        when '.s'
          split = parts[1].split
          split[0].capitalize!
          parts[1] = split.join(' ')
          parts[next_part] = parts[next_part].slice(2, parts[next_part].length)
        when '.e'
          parts[1] = CGI.escape(parts[1])
          parts[next_part] = parts[next_part].slice(2, parts[next_part].length)
        when '.r'
          s1,s2 = get_subst_parts parts[next_part]
          parts[1] = parts[1].sub(s1,s2)
          # Consume the subst clause
          close_bracket = parts[next_part].index(')')
          parts[next_part] = parts[next_part].slice(close_bracket+1, parts[next_part].length)
        when '.t'
          s1 = get_trunc_part parts[next_part]
          i = parts[1].index(s1)
          parts[1] = parts[1].slice(0,i)
          # Consume the trunc clause
          close_bracket = parts[next_part].index(')')
          parts[next_part] = parts[next_part].slice(close_bracket+1, parts[next_part].length)
        else
          parts[next_part] = method
          next_part += 1
          parts[next_part] = remainder
        end

      end
      parts[next_part] = parts[next_part].slice(1, parts[next_part].length) if graved && parts[next_part]

      # Join the parts and return the result.
      [parts.join, new_value]
    end

    def get_subst_parts(s)
      # should be of the form .r(s1,s2)
      open_bracket = s.index '('
      close_bracket = s.index ')'
      s.slice(open_bracket+1, close_bracket-open_bracket-1).split(',')
    end

    def get_trunc_part(s)
      # should be of the form .r(s1,s2)
      open_bracket = s.index '('
      close_bracket = s.index ')'
      s.slice(open_bracket+1, close_bracket-open_bracket-1)
    end

    def get_method(str)
      one_char_method_name = (str.length == 2 || (str.length > 2 && not_alpha(str[2])))
      if one_char_method_name
        'udisert'.each_char do |m|
          method_name = '.' + m
          if str.start_with?(method_name)
            remainder = str.slice(2, str.length)
            return [method_name, remainder]
          end
        end
      end
    end

    def is_digit c
      cp = c.codepoints[0]
      (cp >= 48) && (cp <= 57)
    end

    def not_alpha s
      c = s.codepoints[0]
      return true if c < 65
      return true if c > 122
      return true if c > 90 && c < 97
      false
    end
  end
end