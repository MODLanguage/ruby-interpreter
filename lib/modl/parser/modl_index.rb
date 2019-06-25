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
    # Extracts an index definition from a ParsedPair
    class IndexExtractor
      def self.extract(pair, global)
        item = pair.valueItem if pair.valueItem
        item = pair.array if pair.array

        # collect all values from the object
        if item.is_a? Parsed::ParsedValueItem
          if item&.value&.text
            global.add_to_index(item.value.text)
          elsif item&.value&.array
            item.value.array.abstractArrayItems.each do |avi|
              global.add_to_index(avi.arrayValueItem)
            end
          elsif item&.value&.nbArray
            item.value.nbArray.arrayItems.each do |avi|
              global.add_to_index(avi.arrayValueItem)
            end
          end
        elsif item.is_a? Parsed::ParsedArray
          item.abstractArrayItems.each do |avi|
            global.add_to_index(avi.arrayValueItem)
          end
        end
      end
    end
  end
end