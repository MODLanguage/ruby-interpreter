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
    # This class handles the conversion of objects that refer to classes into instances of those classes.
    # It works recursively since class usage can be nested.
    class InstructionProcessor
      def self.process(global, obj)
        if obj.is_a? Hash
          nvals = {}
          obj.keys.each do |k|
            o = obj[k]
            if o.is_a? String
              nv = process_instruction(global, o)
              nvals[k] = nv unless nv.nil?
            else
              process(global, o)
            end
          end
          obj.merge!(nvals)
        elsif obj.is_a? Array
          i = 0
          while i < obj.length
            o = obj[i]
            if o.is_a? String
              nv = process_instruction(global, o)
              obj[i] = nv unless nv.nil?
            else
              process(global, o)
            end
            i += 1
          end
        end
      end

      def self.process_instruction(global, str)
        case str
        when '%*class'
          return global.class_list
        when '%*method'
          return global.method_list
        when '%*load'
          return global.file_list
        when '%*id'
          return global.id_list
        when '%*name'
          return global.name_list
        when '%*superclass'
          return global.superclass_list
        when '%*assign'
          return global.assign_list
        when '%*transform'
          return global.transform_list
        when '%*allow'
          return global.allow_list
        end
      end
    end
  end
end
