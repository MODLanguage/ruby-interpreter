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
    # Escape-sequence replacements for MODL files.
    class UnicodeEscapes

      # Replace all unicode escape sequences in the supplied string and return the new value.
      def self.process(str)
        return str unless str.is_a? String

        start = 0
        result = str
        loop do

          backslash_u = result.index('\u', start)
          tilde_u = result.index('~u', start)

          break if tilde_u.nil? && backslash_u.nil?

          if tilde_u.nil?
            uni_str_idx = backslash_u
          elsif backslash_u.nil?
            uni_str_idx = tilde_u
          else
            uni_str_idx = [backslash_u, tilde_u].min
          end

          break if uni_str_idx + 6 > result.length

          start = uni_str_idx + 1

          next if uni_str_idx > 0 && result[uni_str_idx - 1] == '~'
          next if uni_str_idx > 0 && result[uni_str_idx - 1] == '\\'

          (value, len) = try_parse(result, uni_str_idx + 2)
          uni_val = value.chr(Encoding::UTF_8)
          left = result.slice(0, uni_str_idx)
          right = result.slice(uni_str_idx + (2 + len), result.length)
          result = left + uni_val + right unless right.nil?
          result = left + uni_val if right.nil?
        end
        result
      end

      def self.enough_digits?(str, idx, n)
        i = 0
        chars = str.chars
        while i < n && (idx + i) < str.length
          c = chars[idx + i]
          unless (('0'..'9').include? c) || (('a'..'f').include? c) || (('A'..'F').include? c)
            return false
          end
          i += 1
        end
        (i == n) ? true : false
      end

      # unicode can be 4 to 6 characters
      def self.try_parse(str, idx)
        if enough_digits?(str, idx, 6)
          value = str.slice(idx, 6).to_i(16)
          if valid_range? value
            return [value, 6]
          end
        end
        if enough_digits?(str, idx, 5)
          value = str.slice(idx, 5).to_i(16)
          if valid_range? value
            return [value, 5]
          end
        end
        if enough_digits?(str, idx, 4)
          value = str.slice(idx, 4).to_i(16)
          if valid_range? value
            return [value, 4]
          end
          if valid_range? value
            return [value, 4]
          end
        end
        [0, 4]
      end

      def self.valid_range?(value)
        return ((0x100000..0x10ffff).include? value) || ((0x10000..0xfffff).include? value) || ((0..0xd7ff).include? value) || ((0xe000..0xffff).include? value) ? true : false
      end
    end
  end
end
