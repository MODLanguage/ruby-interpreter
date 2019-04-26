# frozen_string_literal: true

require 'modl/parser/parsed'
require 'punycode'
require 'modl/parser/sutil'

module Modl
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

        case str
        when '%*class'
          new_value = global.class_list
        when '%*method'
          new_value = global.method_list
        when '%*load'
          new_value = global.file_list
        when '%*id'
          new_value = global.id_list
        when '%*name'
          new_value = global.name_list
        when '%*superclass'
          new_value = global.superclasse_list
        when '%*assign'
          new_value = global.assign_list
        when '%*transform'
          new_value = global.transform_list
        else
          new_value, str = process_tokens(global, original, str, text)
        end

        [str, new_value]
      end

      private

      def self.process_tokens(global, original, str, text)
        new_value = nil
        loop do
          match = MATCHER.match(text.to_s)
          break if match.nil?

          ref = match[0]
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
          elsif new_value.is_a?(Modl::Parser::MODLParserBaseListener)
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
              if p.is_a?(Modl::Parser::MODLParserBaseListener)
                p = p.text
              end
            end
            n = p.to_i
            result = if n.to_s == p
                       # Numeric ref
                       result.nil? ? global.index_value(n, degraved) : result.find_property(n)
                     else
                       # String ref
                       if result.is_a? String
                         StandardMethods.run_method(p, result)
                       elsif result.is_a? Array
                         nil
                       else
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
          while i < parts.length
            result = StandardMethods.run_method(parts[i], result)
            i += 1
          end
          [result, '']
        end
      end

    end
  end
end
