require 'singleton'
require 'modl/parser/parsed'

module Modl::Parser
  class RefProcessor

    include Singleton

    def deref str, values_array, pairs_hash, methods_hash

      puts 'De-reffing: ' + str
      count = str.count('%')
      while count > 0
        str, new_value = split_by_ref_tokens str, values_array, pairs_hash, methods_hash
        count -= 1
      end
      puts 'De-reffing result: ' + str.to_s + ', new_value = ' + new_value.to_s
      [str, new_value]
    end

    def split_by_ref_tokens str, values_array, pairs_hash, methods_hash
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
          if str.start_with?('`%') || str.start_with?('%')
            pair = pairs_hash[best_match]
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
          # TODO: Check for user-defined methods and execute them
          m = methods_hash[method.slice(1, method.length)]

          if m
            puts 'Running method: ' + m['name']
            parts[1] = run_method m['transform'], parts[1]
            parts[next_part] = ''
          else
            parts[next_part] = method
            next_part += 1
            parts[next_part] = remainder
          end
        end

      end
      parts[next_part] = parts[next_part].slice(1, parts[next_part].length) if graved && parts[next_part]

      # Join the parts and return the result.
      if parts[1].is_a? String
        [parts.join, new_value]
      else
        [parts[1], new_value]
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