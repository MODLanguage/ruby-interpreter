# frozen_string_literal: true

require 'modl/parser/parsed'
require 'punycode'
require 'modl/parser/sutil'

module MODL
  module Parser
    # Convert MODL reference to the replacement value
    class RefProcessor

      NESTED_SEPARATOR = '.'
      MATCHER = Regexp.new('((`?\%[0-9][0-9.][a-zA-Z0-9.(),]*`?)|(`?\%[0-9][0-9]*`?)|(`?\%[_a-zA-Z][_a-zA-Z0-9.%(),]*`?)|(`.*`\.[_a-zA-Z0-9.(),%]+)|(`.*`))')

      def self.trivial_reject(str)
        # do a fast check to see if we need to deref - save processing the regex if we don't have to.
        str.is_a?(String) && (str.nil? || str.include?('%') || str.include?('`'))
      end

      # Check str for references and process them.
      # Return the processed string and a new_value if there is one.
      def self.deref(str, global)
        obj = str
        obj, new_value = split_by_ref_tokens str, global if trivial_reject(str)
        [obj, new_value]
      end

      # Process the next %ref token
      def self.split_by_ref_tokens(str, global)
        new_value = nil

        text = str
        original = str

        new_value, str = process_tokens(global, original, str, text) if new_value.nil?

        [str, new_value]
      end

      private

      def self.process_tokens(global, original, str, text)
        new_value = nil
        loop do
          text_s = text.to_s
          match = MATCHER.match(text_s)
          break if match.nil?

          match_index = text_s.index(match[0])
          if match_index > 0
            if text_s[match_index - 1] == '~' || text_s[match_index - 1] == '\\'
              break
            end
            if text_s[match_index + match.length] == '~' || text_s[match_index + match.length] == '\\'
              break
            end
          end


          ref = match[0]
          ref = Sutil.head(ref) if ref.end_with?('%')
          text = Sutil.after(text, ref)
          new_value, remainder = expand(global, ref)
          ref = Sutil.until(ref, remainder)
          if new_value.is_a?(String)
            str = str.sub(ref, new_value)
          elsif new_value.is_a?(Parsed::ParsedArrayItem)
            nv_text = new_value.arrayValueItem.text
            str = if ref == str
                    nv_text
                  else
                    str.sub(ref, nv_text.to_s)
                  end
            new_value = nil
          elsif new_value.is_a?(Parsed::ParsedMapItem)
            raise InterpreterError, 'Interpreter Error: Found a map when expecting an array'
          elsif new_value.is_a?(MODL::Parser::MODLParserBaseListener)
            if new_value.text
              str = if ref == str
                      new_value.text
                    else
                      str.sub(ref, new_value.text.to_s)
                    end
              new_value = nil
            else
              str = nil
            end
          else
            new_value = nil
            raise InterpreterError, 'Cannot resolve reference in : "' + str + '"' if str == original
          end
        end
        return new_value, str
      end

      def self.expand(global, ref)
        result = nil
        prev = nil

        degraved = Sutil.replace(ref, '`', '')

        parts = Sutil.tail(degraved).split('.') if degraved[0] == '%'
        parts = degraved.split('.') unless degraved[0] == '%'

        if degraved.include?('%')
          resolved = 0
          parts.each do |p|
            if p.include?('%')
              p, _ignore = expand(global, p)
              if p.is_a?(MODL::Parser::MODLParserBaseListener)
                p = p.text
              end
            end
            n = p.to_i
            result = if n.to_s == p
                       # Numeric ref
                       if !result.nil? && !result.respond_to?(:find_property)
                         raise InterpreterError, 'Interpreter Error: Invalid obejct reference: ' + degraved
                       end
                       result.nil? ? global.index_value(n, degraved) : result.find_property(n)
                     else
                       # String ref
                       if result.is_a? String
                         StandardMethods.run_method(p, result)
                       elsif result.is_a? Array
                         nil
                       else
                         if !result.nil? && !result.respond_to?(:find_property)
                           raise InterpreterError, 'Interpreter Error: Invalid obejct reference: ' + degraved
                         end
                         result.nil? ? global.pair(p) : result.find_property(p)
                       end
                     end
            break if result.nil?

            prev = result
            resolved += 1
          end
          if prev.nil?
            remainder = ''
            prev = degraved
          else
            remainder = resolved < parts.length ? '.' + parts[resolved..parts.length].join('.') : ''
          end
          [prev, remainder]
        else
          # Remove the graves if there are any.
          result = parts[0]
          i = 1
          stalled = false
          while i < parts.length
            stalled |= StandardMethods.valid_method?(parts[i]) ? false : true

            if stalled
              result << '.'
              result << parts[i]
            else
              result = StandardMethods.run_method(parts[i], result)
            end
            i += 1
          end
          [result, '']
        end
      end

    end
  end
end
