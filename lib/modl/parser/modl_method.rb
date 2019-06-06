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
    # Represents a *method defined by a MODL document.
    class MODLMethod
      attr_accessor :id
      attr_accessor :name
      attr_accessor :transform

      def name_or_id
        @name.nil? ? @id : @name
      end

      # There is a user-defined method transform to run on the str
      def run(str)
        # Consume the elements of the transform spec until there are none left.
        transform = @transform
        while transform && transform.length > 0
          if transform.start_with? 'replace'
            close_bracket = transform.index(')')
            m = Sutil.head(transform, close_bracket + 1).sub!('replace', 'r')
            str = StandardMethods.run_method(m, str)
            # Consume the subst clause
            close_bracket = transform.index(')')
            transform = Sutil.tail(transform, close_bracket + 2)
          elsif transform.start_with? 'trim'
            close_bracket = transform.index(')')
            m = Sutil.head(transform, close_bracket + 1).sub!('trim', 't')
            str = StandardMethods.run_method(m, str)
            # Consume the trunc clause
            close_bracket = transform.index(')')
            transform = Sutil.tail(transform, close_bracket + 2)
          elsif transform.start_with? 'initcap'
            str = str.split.map(&:capitalize) * ' '
            transform = Sutil.tail(transform, 8)
          elsif transform.start_with? 'upcase'
            raise InterpreterError, 'NOT IMPLEMENTED'
          elsif transform.start_with? 'downcase'
            raise InterpreterError, 'NOT IMPLEMENTED'
          elsif transform.start_with? 'sentence'
            raise InterpreterError, 'NOT IMPLEMENTED'
          elsif transform.start_with? 'urlencode'
            raise InterpreterError, 'NOT IMPLEMENTED'
          else
            raise InterpreterError, 'NOT IMPLEMENTED'
          end
        end
        str
      end

    end

    # Extracts a method definition from a ParsedPair
    class MethodExtractor
      def self.extract(pair, global)
        return unless pair.type == 'method'

        mthd = MODLMethod.new
        map = pair.map if pair.map
        map = pair.valueItem&.value&.map if pair.valueItem&.value&.map

        map.mapItems.each do |item|
          next unless item&.pair&.type

          case item&.pair&.type
          when 'id'
            mthd.id = item.pair.valueItem.value.primitive.string.string
          when 'transform'
            mthd.transform = item.pair.valueItem.value.primitive.string.string
          when 'name'
            mthd.name = item.pair.valueItem.value.primitive.string.string
          else
            raise InterpreterError, 'Invalid *method - only *id, *name, and *transform fields expected'
          end
        end

        raise InterpreterError, 'Missing id for method' if mthd.id.nil?
        raise InterpreterError, 'Missing name for method' if mthd.name.nil?
        raise InterpreterError, 'Duplicate method name: ' + mthd.name if global.has_user_method?(mthd.name)
        raise InterpreterError, 'Duplicate method id: ' + mthd.id if global.has_user_method?(mthd.id)

        # store the methods by id and name to make them easier to find later
        global.user_method_id(mthd.id, mthd)
        global.user_method(mthd.name, mthd)
      end
    end

    class StandardMethods
      def self.run_method(mthd, str)
        m = mthd.match(/\w*/)[0]
        case m
        when 'u', 'upcase'
          str.upcase
        when 'd', 'downcase'
          str.downcase
        when 'i', 'initcap'
          str.split.map(&:capitalize) * ' '
        when 's', 'sentence'
          split = str.split
          split[0].capitalize!
          split.join(' ')
        when 'e', 'urlencode'
          CGI.escape(str)
        when 'r', 'replace'
          s1, s2 = get_subst_parts mthd
          str.sub(s1, s2)
        when 't', 'trim'
          s1 = extract_params mthd
          i = str.index(s1)
          Sutil.head(str, i)
        when 'p', 'punydecode'
          Punycode.decode(str)
        else
          str + '.' + mthd
        end
      end

      # Extract the method parameters
      def self.get_subst_parts(s)
        # should be of the form .r(s1,s2)
        result = extract_params(s).split(',')
        result[0] = '' if result.length.zero? || result[0].nil?
        result[1] = '' if result.length == 1 || result[1].nil?
        result
      end

      # Extract the method parameter
      def self.extract_params(str)
        # should be of the form .r(s1,s2)
        Sutil.between(str, '(', ')')
      end

      def self.valid_method?(mthd)
        return 'udisertp'.include?(mthd)
      end
    end
  end
end