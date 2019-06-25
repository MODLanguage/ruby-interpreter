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

require 'modl/parser/parsed'
require 'punycode'
require 'modl/parser/sutil'

module MODL
  module Parser
    # Convert MODL reference to the replacement value
    class RefProcessor

      NESTED_SEPARATOR = '.'
      MATCHER = Regexp.new('((%\w+)(\.\w*<`?\w*`?,`\w*`>)+|(%` ?[\w-]+`[\w.<>,]*%?)|(%\*?[\w]+(\.%?\w*<?[\w,]*>?)*%?))')
      MAX_RECURSE_DEPTH = 10

      def self.trivial_reject(str)
        # do a fast check to see if we need to deref - save processing the regex if we don't have to.
        !(str.is_a?(String) && !str.start_with?('%*') && (str.nil? || str.include?('%') || str.include?('`')))
      end

      # Check str for references and process them.
      # Return the processed string and a new_value if there is one.
      def self.deref(str, global)
        obj = str
        obj, new_value = split_by_ref_tokens str, global unless trivial_reject(str)
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
          text = Sutil.after(text, ref)

          new_value, remainder = expand(0, global, ref)
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
                      str.sub(ref, Sutil.unquote(new_value.text.to_s))
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

      def self.expand(depth, global, ref)
        if depth > MAX_RECURSE_DEPTH
          raise InterpreterError, 'Recursing too deep to resolve: "' + ref + '"'
        end
        result = nil
        prev = nil

        degraved = Sutil.replace(ref, '`', '')

        parts = Sutil.tail(degraved).split('.') if degraved[0] == '%'
        parts = degraved.split('.') unless degraved[0] == '%'
        parts[-1] = Sutil.head(parts[-1]) if parts[-1].end_with?('%')

        if degraved.include?('%')
          resolved = 0
          parts.each do |p|
            if p.include?('%')
              p, _ignore = expand(depth + 1, global, p)
              if p.is_a?(MODL::Parser::MODLParserBaseListener)
                p = p.text
              end
            end
            n = p.to_i
            result = if n.to_s == p
                       # Numeric ref
                       if !result.nil? && !result.respond_to?(:find_property)
                         raise InterpreterError, 'Interpreter Error: Invalid object reference: ' + degraved
                       end
                       result.nil? ? global.index_value(n, degraved) : result.find_property(n)
                     else
                       # String ref
                       if result.is_a? String
                         if StandardMethods.valid_method?(p)
                           StandardMethods.run_method(p, result)
                         else
                           mthd = global.user_method(p)
                           if !mthd.nil?
                             mthd.run(result)
                           else
                             mthd
                           end
                         end
                       elsif result.is_a? Parsed::ParsedPair
                         prop = result.find_property(p)
                         if result.text && !prop
                           if StandardMethods.valid_method?(p)
                             StandardMethods.run_method(p, result.text)
                           else
                             mthd = global.user_method(p)
                             if !mthd.nil?
                               mthd.run(result.text)
                             else
                               mthd
                             end
                           end
                         else
                           prop
                         end
                       elsif result.is_a? Parsed::ParsedArrayValueItem
                         prop = result.find_property(p)
                         if result.text && !prop
                           if StandardMethods.valid_method?(p)
                             result_text = result.text
                             if result_text.start_with?('`') && result_text.end_with?('`')
                               result_text = Sutil.toptail(result_text)
                             end
                             StandardMethods.run_method(p, result_text)
                           else
                             mthd = global.user_method(p)
                             if !mthd.nil?
                               mthd.run(result.text)
                             else
                               mthd
                             end
                           end
                         else
                           prop
                         end
                       elsif result.is_a? Array
                         nil
                       else
                         if !result.nil? && !result.respond_to?(:find_property)
                           raise InterpreterError, 'Interpreter Error: Invalid object reference: ' + degraved
                         end
                         if result.nil?
                           unless ref.start_with?('%`')
                             a_pair = global.pair(p)
                           end
                           if a_pair.nil?
                             p
                           else
                             a_pair
                           end
                         else
                           result.find_property(p)
                         end
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
          if (prev == Sutil.between(ref, '%', '%')) || (ref.start_with?('%') && prev == Sutil.tail(ref))
            prev = ref
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
