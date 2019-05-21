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
            value2 = item.text
          else
            value2, success = value(global, item.text)
          end
          partial = false
          case condition.operator
          when '='
            wild = value2.is_a?(String) && value2.include?('*') ? true : false
            if wild
              regex = '^'
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
          else
            pair = global.pair(key)
            return k unless pair

            value1 = pair.text
          end
          success = true
        end
        [value1, success]
      end
    end
  end
end

