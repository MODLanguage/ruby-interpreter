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
    # This class handles the conversion of objects that refer to arrays into instances of those arrays.
    # It works recursively since array usage can be nested.
    class ArrayProcessor
      # How deep can the class structure be?
      MAX_RECURSION_DEPTH = 50
      # global is a GlobalParseContext and obj is the extracted Array or Hash from MODL::Parser::Parsed.extract_json
      def self.process(global, obj)
        # Process each object in the array or just process the object if its a hash.
        # Any other object is ignored.
        raise StandardError, 'parameter "global" should be a GlobalParseContext' unless global.is_a?(GlobalParseContext)

        if obj.is_a? Array
          obj.each do |o|
            process_obj global, o if o.is_a? Hash
          end
        elsif obj.is_a? Hash
          process_obj global, obj
        end
      end

      private

      # Process the contents of the supplied array
      def self.process_array(global, the_array, k, value)

        return [k, value] if value.length.zero?
        field_count = value[0].length
        return [k, value] if field_count.zero?

        # Get the class for the 'of' field of the array.
        clazz = global.classs the_array.of
        raise StandardError, 'No class with id or name =' + the_array.of + ' could be found.' if clazz.nil?

        # Get the *assign array from the class and make sure we have an entry of size field_count
        assignment_list = clazz.keylist_of_length field_count
        raise StandardError, 'No assignment list of length ' + field_count.to_s + ' for class with id or name =' + the_array.of + ' could be found.' if assignment_list.nil?

        result = []

        value.each do |record|
          object = {}
          i = 0
          assignment_list.each do |field|
            field_class = global.classs field
            if field_class
              object[field_class.name_or_id] = record[i]
            else
              object[field] = record[i]
            end
            i += 1
          end
          result << object
        end

        return [the_array.name_or_id, result]
      end

      # Replace the existing object with the new array instance and a new key
      # We need to keep the same key order, hence this method below
      def self.replace_value(obj, old_k, new_k, new_v)
        tmp = obj.dup
        obj.clear
        tmp.keys.each do |tmpk|
          tmpv = tmp[tmpk]
          if tmpk == old_k
            obj[new_k] = new_v
          else
            obj[tmpk] = tmpv
          end
        end
      end

      def self.process_obj(global, obj)
        obj.keys.each do |k|
          value = obj[k]
          # Does the key refer to an array that we have parsed or loaded?
          the_array = global.arrays(k)
          if the_array
            # Yes so convert this value to an instance of that array
            new_k, new_v = process_array global, the_array, k, value
            # Replace the existing object with the new array instance and a new key
            # We need to keep the same key order, hence this method below
            replace_value obj, k, new_k, new_v
          else
            new_v = value
          end
          # Recurse into the value in case it has contents that also refer to arrays.
          process global, new_v
        end
      end

    end
  end
end
