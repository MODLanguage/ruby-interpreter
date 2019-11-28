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
    class KeylistExtractor
      def self.extract(pair, item)
        # the item must be an array of arrays
        pair.key_lists = []
        last_keylist_len = 0
        if item.is_a?(Parsed::ParsedValueItem) && item.value.is_a?(Parsed::ParsedValue) && item.value.array
          item.value.array.abstractArrayItems.each do |avi|
            key_list = []
            avi.arrayValueItem.array.abstractArrayItems.each do |key|
              key_list << key.arrayValueItem.primitive.string.string if key.arrayValueItem.primitive.string
              key_list << key.arrayValueItem.primitive.number.num if key.arrayValueItem.primitive.number
            end
            if key_list.length > last_keylist_len
              last_keylist_len = key_list.length
            else
              raise InterpreterError, 'Error: Key lists in *assign are not in ascending order of list length: ' + key_list.to_s
            end
            pair.key_lists << key_list
          end
        elsif item.is_a?(Parsed::ParsedArray)
          item.abstractArrayItems.each do |avi|
            key_list = []
            avi.arrayValueItem.array.abstractArrayItems.each do |key|
              key_list << key.arrayValueItem.primitive.string.string if key.arrayValueItem.primitive.string
              key_list << key.arrayValueItem.primitive.number.num if key.arrayValueItem.primitive.number
            end
            if key_list.length > last_keylist_len
              last_keylist_len = key_list.length
            else
              raise InterpreterError, 'Error: Key lists in *assign are not in ascending order of list length.'
            end
            pair.key_lists << key_list
          end
        elsif item.is_a?(Parsed::ParsedValueItem) && !item.value.nbArray.nil?
          item.value.nbArray.arrayItems.each do |avi|
            key_list = []
            avi.arrayValueItem.array.abstractArrayItems.each do |key|
              key_list << key.arrayValueItem.primitive.string.string if key.arrayValueItem.primitive.string
              key_list << key.arrayValueItem.primitive.number.num if key.arrayValueItem.primitive.number
            end
            if key_list.length > last_keylist_len
              last_keylist_len = key_list.length
            else
              raise InterpreterError, 'Error: Key lists in *assign are not in ascending order of list length.'
            end
            pair.key_lists << key_list
          end
        else
          raise InterpreterError, 'Array of arrays expected for: ' + pair.key
        end
      end
    end
  end
end