module Modl
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
            transform = Sutil.trail(transform, close_bracket + 2)
          elsif transform.start_with? 'trim'
            close_bracket = transform.index(')')
            m = Sutil.head(transform, close_bracket + 1).sub!('trim', 't')
            str = StandardMethods.run_method(m, str)
            # Consume the trunc clause
            close_bracket = transform.index(')')
            transform = Sutil.trail(transform, close_bracket + 2)
          elsif transform.start_with? 'initcap'
            str = str.split.map(&:capitalize) * ' '
            transform = Sutil.trail(transform, 8)
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
            mthd.id = item.pair.valueItem.value.string.string
          when 'transform'
            mthd.transform = item.pair.valueItem.value.string.string
          when 'name'
            mthd.name = item.pair.valueItem.value.string.string
          else
            raise InterpreterError, 'Invalid *method - only *id, *name, and *transform fields expected'
          end
        end

        raise InterpreterError, 'Missing id for method' if mthd.id.nil?
        raise InterpreterError, 'Missing name for method' if mthd.name.nil?
        raise InterpreterError, 'Duplicate method name: ' + mthd.name unless global.methods_hash[mthd.name].nil?
        raise InterpreterError, 'Duplicate method id: ' + mthd.id unless global.methods_hash[mthd.id].nil?

        # store the methods by id and name to make them easier to find later
        global.methods_hash[mthd.id] = mthd
        global.methods_hash[mthd.name] = mthd
      end
    end

    class StandardMethods
      def self.run_method(m, str)
        case m[0]
        when 'u'
          return str.upcase
        when 'd'
          return str.downcase
        when 'i'
          return str.split.map(&:capitalize) * ' '
        when 's'
          split = str.split
          split[0].capitalize!
          return split.join(' ')
        when 'e'
          return CGI.escape(str)
        when 'r'
          s1, s2 = get_subst_parts m
          return str.sub(s1, s2)
        when 't'
          s1 = extract_params m
          i = str.index(s1)
          return Sutil.head(str, i)
        when 'p'
          return Punycode.decode(str)
        else
          return str + '.' + m
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
    end
  end
end