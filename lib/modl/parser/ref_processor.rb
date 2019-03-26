require 'singleton'
require 'modl/parser/parsed'

module Modl::Parser
  class RefProcessor

    include Singleton

    def deref str, values_array, pairs_hash

      puts 'De-reffing: ' + str
      if str.include?('%')
        str, new_value = split_by_ref_tokens str, values_array, pairs_hash
      end
      puts 'De-reffing result: ' + str
      [str, new_value]
    end

    def split_by_ref_tokens str, values_array, pairs_hash
      parts = []
      percent = str.index '%'

      parts << str.slice(0, percent)
      skip = 1
      graved = false
      if str[percent + 1] == '`'
        skip += 1
        graved = true
      end
      parts << str.slice(percent + skip, str.length)

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
          parts[1] = '%' + key
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
          new_value = pairs_hash[best_match]
        end

      end

      # Are there any methods to run?
      if parts.length == 3 && parts[2][0] == '.'
        parts[2] = parts[2].slice(1, parts[2].length)
        while parts[2].length > 0 && 'udise'.include?(parts[2][0])
          method = parts[2][0]
          parts[2] = parts[2].slice(1, parts[2].length)
          parts[1] = run_method method, parts[1]
        end
        parts[2] = parts[2].slice(1, parts[2].length) if graved
      end

      # Join the parts and return the result.
      [parts.join, new_value]
    end

    def run_method(m, str)
      case m
      when 'u'
        return str.upcase
      when 'd'
        return str.downcase
      when 'i'
        return str.split.map(&:capitalize) * ' '
      when 's'
        split = str.split
        split[0].capitalize!
        return split.join(' ')
      when 'e'
        return CGI.escape(str)
      else
        str
      end
    end

    def is_digit c
      (c.codepoints[0] >= 48) && (c.codepoints[0] <= 57)
    end

  end
end