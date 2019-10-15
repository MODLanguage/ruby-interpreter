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

          value = result.slice(uni_str_idx + 2, 4).to_i(16)
          uni_val = value.chr(Encoding::UTF_8)
          left = result.slice(0, uni_str_idx)
          right = result.slice(uni_str_idx + 6, result.length)
          result = left + uni_val + right unless right.nil?
          result = left + uni_val if right.nil?
        end
        result
      end
    end
  end
end
