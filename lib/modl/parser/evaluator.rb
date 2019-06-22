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
    # Evaluate a conditional expression
    class Evaluator
      # Evaluate the given condition
      def self.evaluate(global, condition)
        return false if global.nil? || !global.is_a?(GlobalParseContext) || !condition.is_a?(MODL::Parser::Parsed::ParsedCondition)

        start = 0
        if condition.text
          value1, success = value(global, condition.text)
        else
          start = 1
          value1, success = value(global, condition.values[0].text)
        end


        # Handle single-value conditions of the form '{x?}'
        if condition.values.length == start
          return false if value1.nil?
          return false if value1.is_a?(FalseClass)
          return true if value1.is_a?(TrueClass)

          return success ? value1 : false
        end

        # Handle the right-hand side, which might have many values and operators, e.g. '{x=a|b|c|d?}'
        i = start
        result = false
        while i < condition.values.length
          item = condition.values[i]
          if item.primitive.constant
            value2 = Substitutions.process(item.text)
          else
            value2, success = value(global, item.text)
          end
          partial = false
          case condition.operator
          when '='
            wild = value2.is_a?(String) && value2.include?('*') ? true : false
            if wild
              regex = '^'.dup
              value2.each_char do |c|
                regex << (c == '*' ? '.*' : c)
              end
              partial |= !value1.match(regex).nil?
            else
              partial |= value1 == value2
            end
          when '>'
            partial |= value1 > value2
          when '<'
            partial |= value1 < value2
          when '>='
            partial |= value1 >= value2
          when '<='
            partial |= value1 <= value2
          end
          i += 1
          result |= partial
        end
        result
      end

      def self.value(global, k)
        success = false
        if k.is_a?(String) && k.include?('%')
          value1, _ignore = MODL::Parser::RefProcessor.deref(k, global)
          success = true
        elsif k.is_a?(FalseClass)
          value1 = false
          success = true
        elsif k.is_a?(TrueClass)
          value1 = true
          success = true
        elsif k.is_a?(NilClass)
          value1 = nil
        else
          key = k
          ikey = key.to_i
          if ikey.to_s == key
            index_val = global.index[ikey]
            value1 = index_val.respond_to?(:text) ? index_val.text : nil
            value1 = Substitutions.process(value1)
          else
            pair = global.pair(key)
            return Substitutions.process(k) unless pair

            value1 = Substitutions.process(pair.text)
          end
          success = true
        end
        [value1, success]
      end
    end
  end
end

