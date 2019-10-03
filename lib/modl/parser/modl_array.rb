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
    # Represents a *array defined, or loaded by, a MODL document.
    class MODLArray
      attr_accessor :id
      attr_accessor :name
      attr_accessor :of

      def initialize
        @content = {}
      end

      def name_or_id
        @name.nil? ? @id : @name
      end
    end

    # Extract an array from a ParsedPair object
    class ArrayExtractor
      def self.extract(pair, global)
        return unless pair.type == 'array'

        the_array = MODLArray.new
        map = pair.map if pair.map
        map = pair.valueItem&.value&.map if pair.valueItem&.value&.map

        map.mapItems.each do |item|
          next unless item&.pair&.type

          case item&.pair&.type
          when 'id'
            str_value = item.pair.valueItem.value.primitive.string.string
            the_array.id = str_value
          when 'name'
            str_value = item.pair.valueItem.value.primitive.string.string
            the_array.name = str_value
          when 'of'
            str_value = item.pair.valueItem.value.primitive.string.string
            the_array.of = str_value
          else
            # Ignore
          end
        end

        raise InterpreterError, 'Missing id for *array' if the_array.id.nil?

        # Make sure the array name isn't redefining an existing array
        if !global.has_array?(the_array.id) && !global.has_array?(the_array.name)

          # store the arrays by id and name to make them easier to find later
          global.arrays(the_array)
        else
          id = the_array.id.nil? ? 'undefined' : the_array.id
          name = the_array.name.nil? ? 'undefined' : the_array.name
          raise InterpreterError, '*Array name or id already defined - cannot redefine: ' + id + ', ' + name
        end
      end
    end
  end
end