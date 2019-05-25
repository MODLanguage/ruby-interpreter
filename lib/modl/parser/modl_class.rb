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
    # Represents a *class defined, or loaded by, a MODL document.
    class MODLClass
      attr_accessor :id
      attr_accessor :name
      attr_accessor :superclass
      attr_accessor :assign
      attr_accessor :content
      attr_accessor :allow
      attr_accessor :expect

      def initialize
        @content = {}
      end

      # Find a keylist of the right length from the *assign array of arrays.
      def keylist_of_length(len)
        return nil if @assign.nil?

        @assign.each do |kl|
          return kl if kl.length == len
        end
        raise InterpreterError,
              'Interpreter Error: No key list of the correct length in class ' + @id + ' - looking for one of length ' + len.to_s
      end

      def merge_content(new_value)
        @content.each do |k, v|
          new_value[k] = v.extract_hash
        end
        new_value
      end

      def name_or_id
        @name.nil? ? @id : @name
      end
    end

    # Extract a class from a ParsedPair object
    class ClassExtractor
      def self.extract(pair, global)
        return unless pair.type == 'class'

        clazz = MODLClass.new
        map = pair.map if pair.map
        map = pair.valueItem&.value&.map if pair.valueItem&.value&.map

        map.mapItems.each do |item|
          next unless item&.pair&.type

          case item&.pair&.type
          when 'id'
            str_value = item.pair.valueItem.value.primitive.string.string
            raise InterpreterError, 'Reserved class id - cannot redefine: ' + str_value if reserved?(str_value)

            clazz.id = str_value
          when 'name'
            str_value = item.pair.valueItem.value.primitive.string.string
            raise InterpreterError, 'Reserved class name - cannot redefine: ' + str_value if reserved?(str_value)

            clazz.name = str_value
          when 'superclass'
            str_value = item.pair.valueItem.value.primitive.string.string
            clazz.superclass = str_value
          when 'keylist'
            clazz.assign = item.pair.key_lists
          when 'allow'
            clazz.allow = item.pair.array if item.pair.array
            clazz.allow = item.pair.valueItem.value.array if item.pair.valueItem.value.array
          when 'expect'
            clazz.expect = item.pair.array if item.pair.array
            clazz.expect = item.pair.valueItem.value.array if item.pair.valueItem.value.array
          else
            clazz.content[item.pair.key] = item.pair.array if item.pair.array
            clazz.content[item.pair.key] = item.pair.map if item.pair.map
            clazz.content[item.pair.key] = item.pair.valueItem.value if item.pair.valueItem.value
          end
        end

        superclass = clazz.superclass

        if superclass && !reserved?(superclass) && !global.has_class?(superclass)
          raise InterpreterError, 'Invalid superclass: ' + superclass.to_s
        end
        raise InterpreterError, 'Missing id for class' if clazz.id.nil?

        # Make sure the class name isn't redefining an existing class
        if !global.has_class?(clazz.id) && !global.has_class?(clazz.name)

          # store the classes by id and name to make them easier to find later
          global.classs(clazz)
        else
          id = clazz.id.nil? ? 'undefined' : clazz.id
          name = clazz.name.nil? ? 'undefined' : clazz.name
          raise InterpreterError, 'Class name or id already defined - cannot redefine: ' + id + ', ' + name
        end
      end

      # Check for a reserved class name
      def self.reserved?(str)
        %w[map str arr num].include?(str)
      end
    end
  end
end