# frozen_string_literal: true

require 'singleton'
require 'modl/parser/parsed'
require 'punycode'
require 'modl/parser/sutil'

module Modl
  module Parser
    # Convert MODL reference to the replacement value
    class RefProcessor
      include Singleton

      NESTED_SEPARATOR = '.'

      # Check str for references and process them.
      # Return the processed string and a new_value if there is one.
      def deref(str, global)
        # How many refs to process?
        count = str.count('%')
        str, new_value = split_by_ref_tokens str, global if count.positive?
        [str, new_value]
      end

      # Process the next %ref token
      def split_by_ref_tokens(str, global)
        new_value = nil

        loop do
          match = /(`?\%[a-zA-Z0-9.]*`?)/.match(str)
          break if match.nil?

          ref = match[0]
          new_value, remainder = expand(global, ref)
          ref = Sutil.until(ref, remainder)
          if new_value.is_a?(String)
            str.sub!(ref, new_value)
          elsif new_value.is_a?(Modl::Parser::MODLParserBaseListener)
            if new_value.text
              str.sub!(ref, new_value.text.to_s)
            else
              str.sub!(ref, '')
            end
          else
            break
          end
        end
        [str, new_value]
      end

      private

      def expand(global, ref)
        result = nil
        prev = nil
        # Remove the graves if there are any.
        ref = Sutil.toptail(ref) if ref.start_with?('`')

        parts = Sutil.trail(ref).split('.')

        resolved = 0

        parts.each do |p|
          n = p.to_i
          result = if n.to_s == p
                     # Numeric ref
                     result.nil? ? nth_value(global.index, n) : result.find_property(n)
                   else
                     # String ref
                     result.nil? ? global.pairs[p] : result.find_property(p)
                   end
          break if result.nil?
          prev = result
          resolved += 1
        end
        remainder = resolved < parts.length ? '.' + parts[resolved..parts.length].join('.') : ''
        [prev, remainder]
      end

      def nth_value(obj, index)
        return index > obj.length ? nil : obj[index] if obj.is_a? Array
        return index > obj.length ? nil : obj[obj.keys[index]] if obj.is_a? Hash

        nil
      end
    end
  end
end
