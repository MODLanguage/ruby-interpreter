require 'singleton'
require 'modl/parser/parsed'
require 'punycode'
require 'modl/parser/sutil'

module Modl
  module Parser
    # Convert MODL reference to the replacement value
    class RefProcessor
      include Singleton

      # Check str for references and process them.
      # Return the processed string and a new_value if there is one.
      def deref(str, global)
        # How many refs to process?
        count = str.count('%')
        # Not using recursion here because sometime substitutions can't be made, so the recursion would be infinite.
        while (count > 0)
          str, new_value = split_by_ref_tokens str, global
          count -= 1
        end
        [str, new_value]
      end

      # Process the next %ref token
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

        parts << Sutil.head(str, idx)
        skip = graved ? 2 : 1

        parts << Sutil.trail(str, idx + skip)

        # Are there any methods?
        dot_index = parts[1].index('.')
        grave_index = parts[1].index('`')
        grave_index = parts[1].length if grave_index.nil?
        method_str = Sutil.trail(parts[1], dot_index) if dot_index && (dot_index < grave_index)
        # Handle nested refs
        if parts[1].include? '>'
          ref_key = Sutil.until(parts[1], '>')

          # recurse through the nested refs to a final value.
          num_ref_key = ref_key.to_i
          after_gt = Sutil.after(parts[1], '>')
          new_value = num_ref_key.to_s == ref_key ? nested_value(after_gt, global.index[num_ref_key], global) : nested_value(after_gt, global.pairs[ref_key], global)

          # Process the result of recursing down, if we found a result.
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
            parts[2] = Sutil.trail(tmp, tmp.index('`')) if graved
            new_value = nil
          end
        else
          # Check for a numeric key
          key = ''
          while parts[1].length > 0 && digit?(parts[1][0])
            key << parts[1][0]
            parts[1] = Sutil.trail(parts[1])
          end

          if key.length.positive?
            # We found a numeric key so use it on the global index
            index = key.to_i
            tmp = parts[1]
            if index < global.index.length
              index_val = global.index[index]
              parts[1] = index_val.is_a?(Fixnum) || index_val.is_a?(String) ? index_val : index_val.extract_hash
              parts << tmp
            else
              # The index number is too high so just use the original un-dereffed value.
              if key.length.positive?
                parts[1] = '%' + key
              else
                parts[1] = '%' + parts[1]
                parts[1].sub!('`', '') if graved
              end
            end
          else
            #no numeric key so try a text key
            best_match = ''
            # Find the longest matching pair key for parts[1]
            global.pairs.keys.each do |k|
              best_match = k if parts[1].start_with?(k) && k.length > best_match.length
            end

            if best_match.length.positive?
              # We found a match so replace the ref with the new value.
              tmp = parts[1]
              parts[1] = global.pairs[best_match].text
              parts[2] = Sutil.trail(tmp, best_match.length)
              if str.start_with?('`%') || str.start_with?('%')
                pair = global.pairs[best_match]
                if pair.array
                  new_value = pair.array
                  parts[1] = new_value.extract_hash
                end
              end
            else
              # No match so just use the original un-dereffed value.
              if key.length.positive?
                parts[1] = '%' + key
              else
                parts[1] = '%' + parts[1]
                parts[1].sub!('`', '') if graved
              end
            end
          end
        end

        # Are there any methods to run?
        next_part = run_methods(global, method_str, parts)

        parts[next_part] = Sutil.trail(parts[next_part]) if graved && parts[next_part]

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

      private

      # Are there any methods to run?
      def run_methods(global, method_str, parts)
        next_part = 2
        remainder = method_str
        while parts.length == 3 && remainder && remainder[0] == '.'
          method, remainder = get_method remainder

          skip2 = Sutil.trail(parts[next_part], 2)

          case method
          when '.u'
            parts[1] = parts[1].upcase
            parts[next_part] = skip2 if parts[next_part].start_with? method
          when '.d'
            parts[1] = parts[1].downcase
            parts[next_part] = skip2 if parts[next_part].start_with? method
          when '.i'
            parts[1] = parts[1].split.map(&:capitalize) * ' '
            parts[next_part] = skip2 if parts[next_part].start_with? method
          when '.s'
            split = parts[1].split
            split[0].capitalize!
            parts[1] = split.join(' ')
            parts[next_part] = skip2 if parts[next_part].start_with? method
          when '.e'
            parts[1] = CGI.escape(parts[1])
            parts[next_part] = skip2 if parts[next_part].start_with? method
          when '.r'
            s1, s2 = get_subst_parts parts[next_part]
            parts[1] = parts[1].sub(s1, s2)
            # Consume the subst clause
            parts[next_part] = Sutil.after(parts[next_part], ')')
          when '.t'
            s1 = extract_params parts[next_part]
            i = parts[1].index(s1)
            parts[1] = Sutil.head(parts[1], i)
            # Consume the trunc clause
            parts[next_part] = Sutil.after(parts[next_part], ')')
          when '.p'
            encoded = parts[1]
            decoded = Punycode.decode(encoded)
            parts[1] = decoded
            parts[next_part] = skip2 if parts[next_part].start_with? method
          else
            # Check for user-defined methods and execute them
            if method
              m = global.methods_hash[Sutil.trail(method)]

              if m
                parts[1] = run_method m.transform, parts[1]
                parts[next_part] = ''
              else
                parts[next_part] = method
                next_part += 1
                parts[next_part] = remainder
              end
            end
          end

        end
        next_part
      end

      def nested_value ref, value, global
        # deref the ref if it has a % character
        ref, new_value = RefProcessor.instance.deref ref, global if ref.start_with? '%'
        # If its a nested ref extract the first part as the key and save the remainder for later.
        if ref.include?('>')
          end_index = ref.index('`')
          end_index = ref.length if end_index.nil?

          gt_index = ref.index('>')
          if gt_index < end_index
            ref_key = Sutil.head(ref, gt_index)
            remainder = Sutil.trail(ref, gt_index + 1)
          else
            ref_key = Sutil.head(ref, end_index)
          end
        else
          # No more nested references so get the target value and return it.
          # A bit messy, but the parse tree is complex.
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

            return value.arrayValueItem.text + '>' + ref
          elsif value.is_a? Parsed::ParsedNbArray
            num_ref = ref.to_i
            return value.arrayItems[num_ref]
          end
          ref_key = ref
        end

        # Check for dots and graves and slice off the extra
        ref_key = Sutil.until(ref_key, '`')
        ref_key = Sutil.until(ref_key, '.')

        # We need a map, array or nb array to continue the nested de-reffing
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

        # Handle the map, array, or nb array if we can.
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
          return remainder&.length&.positive? ? nested_value(remainder, result, global) : result
        elsif the_nbarray
          result = the_nbarray.arrayItems[ref_key.to_i]
          return remainder&.length&.positive? ? nested_value(remainder, result.arrayValueItem, global) : result
        else
          the_pair = value.valueItem.value.pair
          target_key = the_pair.key if the_pair
        end

        result = the_pair
        if ref_key == target_key
          return remainder && remainder.length > 0 ? nested_value(remainder, result, global) : result.valueItem
        end
        raise Antlr4::Runtime::ParseCancellationException, ref_key + ' item not found for reference ' + ref
      end

      # Extract the method parameters
      def get_subst_parts(s)
        # should be of the form .r(s1,s2)
        extract_params(s).split(',')
      end

      # Extract the method parameter
      def extract_params(str)
        # should be of the form .r(s1,s2)
        Sutil.between(str, '(', ')')
      end

      # Check the string for the next method name and return it.
      def get_method(str)
        one_char_method_name = (str.length == 2 || (str.length > 2 && !alpha?(str[2])))
        if one_char_method_name
          'udisertp'.each_char do |m|
            method_name = '.' + m
            if str.start_with?(method_name)
              remainder = Sutil.trail(str, 2)
              return [method_name, remainder]
            end
          end
        else
          # longer name - possibly a method
          method_name = '.'
          i = 1
          # Scan the rest of the text method name
          while i < str.length && alpha?(str[i])
            method_name << str[i]
            i += 1
          end

          if method_name.length > 1
            remainder = Sutil.trail(str, method_name.length + 1)
            return [method_name, remainder]
          end
        end
      end

      def digit?(c)
        c =~ /[0-9]/
      end

      def alpha?(s)
        s =~ /[a-zA-Z]/
      end

      # There is a user-defined method transform to run on the str
      def run_method(transform, str)
        # Consume the elements of the transform spec until there are none left.
        while transform && transform.length > 0
          if transform.start_with? 'replace'
            s1, s2 = get_subst_parts transform
            s2 = '' if s2.nil?
            str = str.sub(s1, s2)
            # Consume the subst clause
            close_bracket = transform.index(')')
            transform = Sutil.trail(transform, close_bracket + 2)
          elsif transform.start_with? 'trim'
            s1 = extract_params transform
            i = str.index(s1)
            str = Sutil.head(str, i)
            # Consume the trunc clause
            close_bracket = transform.index(')')
            transform = Sutil.trail(transform, close_bracket + 2)
          elsif transform.start_with? 'initcap'
            str = str.split.map(&:capitalize) * ' '
            transform = Sutil.trail(transform, 8)
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
end
