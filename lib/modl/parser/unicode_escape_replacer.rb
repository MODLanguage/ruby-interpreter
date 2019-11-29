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

module MODL
  module Parser
    # Unicode replacements for MODL files.
    class UnicodeEscapeReplacer
      BACKSLASH_U = "\\u"
      TILDE_U = "~u"
      TILDE = '~'
      BACKSLASH = '\\'
      HEX = 16

      def self.convert_unicode_sequences(str)
        start = 0
        result = str

        until result.nil?
          # We could have a backslash-u escape sequence or a ~u escape sequence
          back_slash_u_index = result.index(BACKSLASH_U, start)
          tilde_u_index = result.index(TILDE_U, start)

          # Filter out cases with no escape sequences.
          unicode_str_idx = 0
          if tilde_u_index.nil? && back_slash_u_index.nil?
            break
          elsif tilde_u_index.nil?
            unicode_str_idx = back_slash_u_index # No ~? Must be backslash
          elsif back_slash_u_index.nil?
            unicode_str_idx = tilde_u_index # No backslash? Must be ~
          else
            # Pick the first escaped character and proceed with that one.
            unicode_str_idx = [back_slash_u_index, tilde_u_index].min
          end

          try_parse_result = try_parse(result, unicode_str_idx + 2)

          # Next time round the loop we start searching after the current escape sequence.
          start = unicode_str_idx + 1

          # If the escape sequence is itself escaped then don't replace it
          if unicode_str_idx > 0 && (result[unicode_str_idx - 1] == TILDE || result[unicode_str_idx - 1] == BACKSLASH)
            next
          end

          # Get the codepoint value and replace the escape sequence
          if try_parse_result.code_point > 0
            chars = try_parse_result.code_point.chr(Encoding::UTF_8)
            result = replace(result, chars, unicode_str_idx, try_parse_result.length + 2)
          end
        end
        result
      end

      private

      #
      # Replace a unicode value in a String
      #
      def self.replace(s, value, unicode_str_index, length)
        left = s.slice(0, unicode_str_index)
        ends = [s.length, unicode_str_index + length].min
        right = s.slice(ends, s.length)
        left + value.to_s + right
      end

      #
      # Check whether the value is a valid unicode codepoint
      #
      def self.valid_range?(value)
        (value >= 0x100000 && value <= 0x10ffff) || (value >= 0x10000 && value <= 0xfffff) || (value >= 0 && value <= 0xd7ff) || (value >= 0xe000 && value <= 0xffff)
      end

      #
      # Can we get `n` hex digits from the string at the `idx` location?
      #
      def self.has_enough_digits?(s, idx, n)
        i = 0
        chars = s.chars

        while i < n && (idx + i) < s.length
          c = chars[idx + i]
          unless c =~ /[0-9a-fA-F]/
            return false
          end
          i += 1
        end
        i == n
      end

      #
      # Attempt to parse a unicode character starting at `idx` in `str`
      #
      def self.try_parse(str, idx)
        # Check for a 6-digit unicode value
        if has_enough_digits? str, idx, 6
          value = str.slice(idx, 6).to_i(HEX)
          return TryParse.new(value, 6) if valid_range? value
        end

        # Check for a 5-digit unicode value
        if has_enough_digits? str, idx, 5
          value = str.slice(idx, 5).to_i(HEX)
          return TryParse.new(value, 5) if valid_range? value
        end

        # Check for a 4-digit unicode value
        if has_enough_digits? str, idx, 4
          value = str.slice(idx, 4).to_i(HEX)
          return TryParse.new(value, 4) if valid_range? value
        end
        return TryParse.new(0, 4)
      end
    end

    # Class to hold the result of the tryParse method
    class TryParse
      attr_accessor :code_point
      attr_accessor :length

      def initialize(code, len)
        @code_point = code
        @length = len
      end
    end
  end
end
