require 'modl/parser/MODLParserBaseListener'
require 'antlr4/runtime/parse_cancellation_exception'

module Modl::Parser
  class Parsed < Modl::Parser::MODLParserBaseListener
    attr_reader :structures

    def initialize
      @structures = []
      @classes = {}
    end

    def enterModl(ctx)
      ctx.modl_structure.each do |str|
        structure = ParsedStructure.new
        str.enter_rule(structure)
        @structures << structure
        extract_classes_from structure
      end
    end

    def extract_classes_from structure
      if structure&.pair&.type == 'class'
        clazz = {}
        map = structure.pair.map
        map.mapItems.each do |item|
          clazz['id'] = item&.pair&.valueItem&.value&.string&.string if item&.pair&.type == 'id'
          clazz['name'] = item&.pair&.valueItem&.value&.string&.string if item&.pair&.type == 'name'
          clazz['superclass'] = item&.pair&.valueItem&.value&.string&.string if item&.pair&.type == 'superclass'
          clazz['keylist'] = item&.pair&.key_lists if item&.pair&.type == 'keylist'
        end

        raise Antlr4::Runtime::ParseCancellationException, 'Missing id for class' if clazz['id'].nil?
        raise Antlr4::Runtime::ParseCancellationException, 'Missing name for class' if clazz['name'].nil?
        raise Antlr4::Runtime::ParseCancellationException, 'Missing superclass for class' if clazz['superclass'].nil?

        # Does the class name or id already exist?
        raise Antlr4::Runtime::ParseCancellationException, 'Duplicate class name: ' + clazz['name'] unless @classes[clazz['name']].nil?
        raise Antlr4::Runtime::ParseCancellationException, 'Duplicate class id: ' + clazz['id'] unless @classes[clazz['id']].nil?


        # store the classes by id and name to make them easier to find later
        @classes[clazz['id']] = clazz
        @classes[clazz['name']] = clazz
      end
      # TODO: Recurse to find all pairs in case they're classes.
    end

    def exitModl(ctx)
    end

    def enterModl_structure(ctx)
    end

    def exitModl_structure(ctx)
    end

    def enterModl_map(ctx)
    end

    def exitModl_map(ctx)
    end

    def enterModl_array(ctx)
    end

    def exitModl_array(ctx)
    end

    def enterModl_nb_array(ctx)
    end

    def exitModl_nb_array(ctx)
    end

    def enterModl_pair(ctx)
    end

    def exitModl_pair(ctx)
    end

    def enterModl_value_item(ctx)
    end

    def exitModl_value_item(ctx)
    end

    def enterModl_top_level_conditional(ctx)
    end

    def exitModl_top_level_conditional(ctx)
    end

    def enterModl_top_level_conditional_return(ctx)
    end

    def exitModl_top_level_conditional_return(ctx)
    end

    def enterModl_map_conditional(ctx)
    end

    def exitModl_map_conditional(ctx)
    end

    def enterModl_map_conditional_return(ctx)
    end

    def exitModl_map_conditional_return(ctx)
    end

    def enterModl_map_item(ctx)
    end

    def exitModl_map_item(ctx)
    end

    def enterModl_array_conditional(ctx)
    end

    def exitModl_array_conditional(ctx)
    end

    def enterModl_array_conditional_return(ctx)
    end

    def exitModl_array_conditional_return(ctx)
    end

    def enterModl_array_item(ctx)
    end

    def exitModl_array_item(ctx)
    end

    def enterModl_value_conditional(ctx)
    end

    def exitModl_value_conditional(ctx)
    end

    def enterModl_value_conditional_return(ctx)
    end

    def exitModl_value_conditional_return(ctx)
    end

    def enterModl_condition_test(ctx)
    end

    def exitModl_condition_test(ctx)
    end

    def enterModl_operator(ctx)
    end

    def exitModl_operator(ctx)
    end

    def enterModl_condition(ctx)
    end

    def exitModl_condition(ctx)
    end

    def enterModl_condition_group(ctx)
    end

    def exitModl_condition_group(ctx)
    end

    def enterModl_value(ctx)
    end

    def exitModl_value(ctx)
    end

    def enterModl_array_value_item(ctx)
    end

    def exitModl_array_value_item(ctx)
    end

    def self.additionalStringProcessing(text)
      # Special case for a possibly empty graved string ``
      unless text.nil?
        matchData = /^`([^`]*)`$/.match text
        return matchData[1] if matchData && matchData.length > 0
      end
      text
    end

    class ParsedMap < Modl::Parser::MODLParserBaseListener
      attr_reader :mapItems

      def enterModl_map(ctx)
        if ctx.modl_map_item != nil
          @mapItems = []
          ctx.modl_map_item.each do |mi|
            mapItem = ParsedMapItem.new
            mi.enter_rule(mapItem)
            @mapItems << mapItem
          end
        end
      end

      def extract_hash
        puts 'ParsedMap.extract_hash'
        result = []
        mapItems.each do |i|
          result << i.extract_hash
        end
        if result.length == 1
          return result[0]
        end
        result
      end

    end

    class ParsedMapItem < Modl::Parser::MODLParserBaseListener
      attr_reader :pair
      attr_reader :mapConditional

      def enterModl_map_item(ctx)
        if ctx.modl_pair() != nil
          @pair = ParsedPair.new
          ctx.modl_pair().enter_rule(@pair)
        end
        if ctx.modl_map_conditional != nil
          @mapConditional = ParsedMapConditional.new
          ctx.modl_map_conditional.enter_rule(@mapConditional)
        end
      end

      def extract_hash
        puts 'ParsedMapItem.extract_hash'

        return @pair.extract_hash if @pair
        return @mapConditional.extract_hash if @mapConditional
      end

    end

    class ParsedStructure < Modl::Parser::MODLParserBaseListener
      attr_reader :array
      attr_reader :pair
      attr_reader :top_level_conditional
      attr_reader :map

      def enterModl_structure(ctx)
        if !ctx.modl_pair.nil?
          @pair = ParsedPair.new
          ctx.modl_pair.enter_rule(@pair)
        elsif !ctx.modl_top_level_conditional.nil?
          @top_level_conditional = ParsedTopLevelConditional.new
          ctx.modl_top_level_conditional.enter_rule(@top_level_conditional)
        elsif !ctx.modl_map.nil?
          @map = ParsedMap.new
          ctx.modl_map.enter_rule(@map)
        elsif !ctx.modl_array.nil?
          @array = ParsedArray.new
          ctx.modl_array.enter_rule(@array)
        end
      end

      def extract_hash
        puts 'ParsedStructure.extract_hash'

        return @array.extract_hash if @array
        return @pair.extract_hash if @pair
        return @top_level_conditional.extract_hash if @top_level_conditional
        return @map.extract_hash if @map
      end
    end

    class ParsedPair < Modl::Parser::MODLParserBaseListener
      attr_reader :key
      attr_reader :map
      attr_reader :array
      attr_reader :valueItem
      attr_reader :key_lists
      attr_reader :type # A string set to the type of pair that we have found bases on its key
      attr_reader :text # The simple text value rather than the object

      class << self
        @@index = []
        @@pairs = {}
      end

      def extract_hash
        puts 'ParsedPair.extract_hash for key = ' + @key

        return if @type == 'index'
        return if @type == 'hidden'

        value = @array.extract_hash if @array
        value = @valueItem.extract_hash if @valueItem
        value = @map.extract_hash if @map

        if value.is_a?(String) && value.start_with?('%')
          {@key => @text}
        else
          {@key => value}
        end
      end

      def enterModl_pair(ctx)
        @type = 'pair'

        @key = ctx.STRING.to_s unless ctx.STRING.nil?
        unless ctx.QUOTED.nil?
          @key = ctx.QUOTED.to_s
          @key = key.slice(1, key.length - 2) # remove the quotes
        end

        @type = 'class' if @key == '*c' || @key == '*class'
        @type = 'id' if @key == '*i' || @key == '*id'
        @type = 'name' if @key == '*n' || @key == '*name'
        @type = 'superclass' if @key == '*s' || @key == '*superclass'
        @type = 'keylist' if @key == '*a' || @key == '*assign'
        @type = 'version' if @key == '*V' || @key == '*VERSION'
        @type = 'method' if @key == '*m' || @key == '*method'
        @type = 'transform' if @key == '*t' || @key == '*transform'
        @type = 'import' if @key == '*I' || @key == '*IMPORT'
        @type = 'index' if @key == '?'
        @type = 'hidden' if @key.start_with? '_'

        raise Antlr4::Runtime::ParseCancellationException, 'Invalid keyword: ' + @key if @type == 'pair' && @key.start_with?('*')

        if !ctx.modl_array.nil?
          @array = ParsedArray.new
          ctx.modl_array.enter_rule(@array)
        elsif !ctx.modl_map.nil?
          @map = ParsedMap.new
          ctx.modl_map.enter_rule(@map)
        elsif !ctx.modl_value_item.nil?
          @valueItem = ParsedValueItem.new
          ctx.modl_value_item.enter_rule(@valueItem)
        end

        # Type-specific processing
        case @type
        when 'class'
          # Nothing to do - classes are handled at the top level.
        when 'id'
          extract_value @valueItem
        when 'name'
          extract_value @valueItem
        when 'superclass'
          extract_value @valueItem
        when 'keylist'
          extract_key_list @valueItem
        when 'version'
          extract_value @valueItem
        when 'method'
          extract_value @valueItem
        when 'transform'
          extract_transform @valueItem
        when 'import'
          extract_value @valueItem
        when 'index'
          extract_index @valueItem
        when 'hidden'
          extract_value @valueItem
        else
          extract_value @valueItem
          if !@text.nil? && @text.is_a?(String) && @text.start_with?('%')
            index_key = @text.slice(1, @text.length)
            if (index_key.codepoints[0] >= 48) && (index_key.codepoints[0] <= 57)
              i = index_key.to_i
              @text = @@index[i].text if i < @@index.length
            else
              if @text.include? '>'
                puts 'NESTED REF : ' + @text
                ref_key = @text.slice(1, @text.index('>') - 1)

                new_value = nested_value(@text.slice(@text.index('>') + 1, @text.length), @@pairs[ref_key])
                @valueItem = new_value
              else
                puts 'TEXT REF : ' + @text
                ref_key = @text.slice(1, @text.length)
                new_value = @@pairs[ref_key]
              end

              if new_value.is_a? ParsedMap
                @map = new_value
              elsif new_value.is_a? ParsedArray
                @array = new_value
              elsif new_value.is_a? ParsedValueItem
                @valueItem = new_value
              else
                @text = extract_value new_value
              end
            end
          end
        end

        k = @key unless @key.start_with?('_')
        k = @key.slice(1, @key.length) if @key.start_with?('_')
        @@pairs[k] = self
      end

      def nested_value ref, value
        unless ref.include? '>'
          if value.valueItem && value.valueItem.value.value_obj.is_a?(ParsedPair)
            return value.valueItem.value.value_obj.valueItem.value.value_obj
          end

          ref_key = ref
        else
          ref_key = ref.slice(0, ref.index('>'))
          remainder = ref.slice(ref.index('>') + 1, ref.length)
        end


        puts ref + ' : ' + ref_key

        the_value_item = value.valueItem

        the_map = (value.map) ? value.map : the_value_item.value.map

        if the_map
          map_items = the_map.mapItems
          map_item = map_items[0]
          the_pair = map_item.pair
          target_key = the_pair.key
        else
          the_pair = the_value_item.value.pair
          if the_pair
            target_key = the_pair.key
            puts 'target_key = ' + target_key
          end
        end

        if ref_key == target_key
          result = the_pair
          if remainder && remainder.length > 0
            puts 'remainder = ' + remainder
            return nested_value(remainder, result)
          else
            puts 'result key = ' + result.key
            return result.valueItem
          end
        else
          raise Antlr4::Runtime::ParseCancellationException, ref_key + ' item not found for reference ' + ref
        end
      end

      def extract_value item
        @text = item.value.text if item.is_a?(ParsedValueItem)
        @text = item.valueItem.value.text if item.is_a?(ParsedPair)
      end

      def extract_index item
        # collect all values from the object - it should be an nb_array
        if (item.is_a? ParsedValueItem)
          if item&.value&.text
            @@index << item.value.text
          elsif item&.value&.array
            item.value.array.abstractArrayItems.each do |avi|
              @@index << avi.arrayValueItem
            end
          elsif item&.value&.nbArray
            item.value.nbArray.arrayItems.each do |avi|
              @@index << avi.arrayValueItem
            end
          end
        else
          raise Antlr4::Runtime::ParseCancellationException, 'The index should have one or more values'
        end
      end

      def extract_key_list item
        # the item must be an array of arrays
        @key_lists = []
        if item.is_a?(ParsedValueItem) && item.value.is_a?(ParsedValue) && item.value.array
          item.value.array.abstractArrayItems.each do |avi|
            key_list = []
            avi.arrayValueItem.array.abstractArrayItems.each do |key|
              key_list << key.arrayValueItem.string.string
            end
            @key_lists << key_list
          end
        else
          raise Antlr4::Runtime::ParseCancellationException, 'Array of arrays expected for: ' + @key
        end
      end

      def extract_transform item
        @transform = item.value.string.string
      end
    end

    class ParsedArrayValueItem < Modl::Parser::MODLParserBaseListener
      attr_reader :map
      attr_reader :array
      attr_reader :pair
      attr_reader :quoted
      attr_reader :number
      attr_reader :trueVal
      attr_reader :falseVal
      attr_accessor :nilVal
      attr_reader :string
      attr_reader :text # The simple text value rather than the object

      def extract_hash
        puts 'ParsedArrayValueItem.extract_hash'

        return @map.extract_hash if @map
        return @array.extract_hash if @array
        return @nbArray.extract_hash if @nbArray
        return @pair.extract_hash if @pair

        return @text unless @number
        return @text.to_i
      end

      def enterModl_array_value_item(ctx)
        @text = nil
        if !ctx.NUMBER.nil?
          @number = ParsedNumber.new(ctx.NUMBER.text)
          @text = @number.num
        elsif !ctx.modl_map.nil?
          @map = ParsedMap.new
          ctx.modl_map.enter_rule(@map)
        elsif !ctx.modl_array.nil?
          @array = ParsedArray.new
          ctx.modl_array.enter_rule(@array)
        elsif !ctx.modl_pair.nil?
          @pair = ParsedPair.new
          ctx.modl_pair.enter_rule(@pair)
        elsif !ctx.STRING.nil?
          @text = Parsed.additionalStringProcessing(ctx.STRING.text)
          @string = ParsedString.new(@text)
        elsif !ctx.QUOTED.nil?
          @text = additionalStringProcessing(ctx.QUOTED.text)
          @quoted = ParsedQuoted.new(@text)
        elsif !ctx.Null.nil?
          @nilVal = ParsedNull.instance
          @text = 'null'
        elsif !ctx.TRUE.nil?
          @trueVal = ParsedTrue.instance
          @text = 'true'
        elsif !ctx.FALSE.nil?
          @falseVal = ParsedFalse.instance
          @text = 'false'
        end

        # ignoring comments!
      end
    end

    class ParsedValueItem < Modl::Parser::MODLParserBaseListener
      attr_reader :value
      attr_reader :valueConditional

      def enterModl_value_item(ctx)
        unless ctx.modl_value_conditional.nil?
          @valueConditional = ParsedValueConditional.new
          ctx.modl_value_conditional.enter_rule(@valueConditional)
        end
        unless ctx.modl_value.nil?
          @value = ParsedValue.new
          ctx.modl_value.enter_rule(@value)
        end
      end

      def extract_hash
        puts 'ParsedValueItem.extract_hash'

        return @value.extract_hash if @value
        return @valueConditional.extract_hash if @valueConditional
      end

    end

    class ParsedValue < Modl::Parser::MODLParserBaseListener
      attr_reader :map
      attr_reader :array
      attr_reader :nbArray
      attr_reader :pair
      attr_reader :quoted
      attr_reader :number
      attr_reader :trueVal
      attr_reader :falseVal
      attr_reader :nilVal
      attr_reader :string
      attr_reader :text # The simple text value rather than the object

      def extract_hash
        puts 'ParsedValue.extract_hash'

        return @map.extract_hash if @map
        return @array.extract_hash if @array
        return @nbArray.extract_hash if @nbArray
        return @pair.extract_hash if @pair

        @text
      end

      def value_obj
        return @map if @map
        return @array if @array
        return @nbArray if @nbArray
        return @pair if @pair
        return @quoted if @quoted
        return @number if @number
        return @trueVal if @trueVal
        return @falseVal if @falseVal
        return @nilVal if @nilVal
        return @string if @string
        @text
      end

      def enterModl_value(ctx)
        if !ctx.NUMBER.nil?
          @number = ParsedNumber.new(ctx.NUMBER.text)
          @text = @number.num
        elsif !ctx.modl_map.nil?
          @map = ParsedMap.new
          ctx.modl_map.enter_rule(@map)
        elsif !ctx.modl_nb_array.nil?
          @nbArray = ParsedNbArray.new
          ctx.modl_nb_array.enter_rule(@nbArray)
        elsif !ctx.modl_array.nil?
          @array = ParsedArray.new
          ctx.modl_array.enter_rule(@array)
        elsif !ctx.modl_pair.nil?
          @pair = ParsedPair.new
          ctx.modl_pair.enter_rule(@pair)
        elsif !ctx.STRING.nil?
          @text = Parsed.additionalStringProcessing(ctx.STRING.text)
          @string = ParsedString.new(@text)
        elsif !ctx.QUOTED.nil?
          @text = Parsed.additionalStringProcessing(ctx.QUOTED.text)
          @quoted = ParsedQuoted.new(@text)
        elsif !ctx.NULL.nil?
          @nilVal = ParsedNull.instance
          @text = 'null'
        elsif !ctx.TRUE.nil?
          @trueVal = ParsedTrue.instance
          @text = 'true'
        elsif !ctx.FALSE.nil?
          @falseVal = ParsedFalse.instance
          @text = 'false'
        end
        # ignoring comments!
      end
    end

    class ParsedString
      attr_reader :string

      def initialize(string)
        @string = string
      end

      def extract_hash
        @string
      end
    end

    class ParsedNumber
      attr_reader :num

      def initialize(string)
        @num = string.to_i
      end
    end

    class ParsedQuoted
      attr_reader :string

      def initialize(string)
        @string = string
      end
    end

    class ParsedConditionTest < Modl::Parser::MODLParserBaseListener
      attr_reader :subConditionList

      def initialize
        @subConditionList = []
      end

      def enterModl_condition_test(ctx)
        unless ctx.children.empty?
          lastOperator = nil
          shouldNegate = false
          ctx.children.each do |child|
            if child.is_a? MODLParser::Modl_condition_groupContext
              conditionGroup = ParsedConditionGroup.new
              child.enter_rule(conditionGroup)

              p = OpenStruct.new
              p.a = lastOperator
              p.b = shouldNegate
              @subConditionList << p
              lastOperator = nil
              shouldNegate = false
            elsif child.is_a? MODLParser::Modl_conditionContext
              condition = ParsedCondition.new
              child.enter_rule(condition)
              p = OpenStruct.new
              p.a = lastOperator
              p.b = shouldNegate
              @subConditionList << p
              lastOperator = nil
              shouldNegate = false
            else
              if child.text == '!'
                shouldNegate = true
              else
                lastOperator = child.text
              end
            end
          end
        end
      end
    end

    class ParsedConditionGroup < Modl::Parser::MODLParserBaseListener
      attr_reader :conditionsTestList

      def initialize
        @conditionsTestList = []
      end

      def enterModl_condition_group(ctx)
        unless ctx.children.empty?
          lastOperator = nil
          ctx.children.each do |child|
            if child.is_a? MODLParser::Modl_condition_testContext
              conditionTest = ParsedConditionTest.new
              child.enter_rule(conditionTest)
              p = OpenStruct.new
              p.a = conditionTest
              p.b = lastOperator
              @conditionsTestList << p
              lastOperator = nil
            else
              if (child.text == '') || (child.text == '}')
              else
                lastOperator = child.text
              end
            end
          end
        end
      end
    end

    class ParsedCondition < Modl::Parser::MODLParserBaseListener
      attr_reader :key
      attr_reader :operator
      attr_reader :values

      def initialize
        @values = []
      end

      def enterModl_condition(ctx)
        @key = ctx.STRING.text unless ctx.STRING.nil?
        @operator = ctx.modl_operator.text unless ctx.modl_operator.nil?
        ctx.modl_value.each do |v|
          value = ParsedValue.new
          v.enter_rule(value)
          @values << value
        end
      end
    end

    class ParsedMapConditionalReturn < Modl::Parser::MODLParserBaseListener
      attr_reader :mapItems

      def initialize
        @mapItems = []
      end

      def enterModl_map_conditional_return(ctx)
        unless ctx.modl_map_item.empty?
          ctx.modl_map_item.each do |mi|
            mapItem = ParsedMapItem.new
            mi.enter_rule(mapItem)
            @mapItems << mapItem
          end
        end
      end
    end

    class ParsedMapConditional < Modl::Parser::MODLParserBaseListener
      attr_reader :mapConditionals

      def initialize
        @mapConditionals = {}
      end

      def enterModl_map_conditional(ctx)
        i = 0
        while i < ctx.modl_condition_test.size
          conditionTest = ParsedConditionTest.new
          ctx.modl_condition_test_i(i).enter_rule(conditionTest)

          conditionalReturn = ParsedMapConditionalReturn.new
          ctx.modl_map_conditional_return_i(i).enter_rule(conditionalReturn)
          @mapConditionals[conditionTest] = conditionalReturn

          if ctx.modl_map_conditional_return.size > ctx.modl_condition_test.size
            conditionTest = ParsedConditionTest.new
            conditionalReturn = ParsedMapConditionalReturn.new
            ctx.modl_map_conditional_return_i(ctx.modl_map_conditional_return.size - 1).enter_rule(conditionalReturn)
            @mapConditionals[conditionTest] = conditionalReturn
          end
          i += 1
        end
      end
    end

    class ParsedTopLevelConditionalReturn < Modl::Parser::MODLParserBaseListener
      attr_reader :structures

      def initialize
        @structures = []
      end

      def enterModl_top_level_conditional_return(ctx)
        unless ctx.modl_structure.empty?
          # ctx.modl_structure.forEach(str ->
          ctx.modl_structure.each do |str|
            structure = ParsedStructure.new
            str.enter_rule(structure)
            @structures << structure
          end
        end
      end
    end

    class ParsedTopLevelConditional < Modl::Parser::MODLParserBaseListener
      attr_reader :topLevelConditionalReturns

      def initialize
        @topLevelConditionalReturns = {}
      end

      def enterModl_top_level_conditional(ctx)
        i = 0
        while i < ctx.modl_condition_test.size
          conditionTest = ParsedConditionTest.new
          ctx.modl_condition_test_i(i).enter_rule(conditionTest)

          conditionalReturn = ParsedTopLevelConditionalReturn.new
          ctx.modl_top_level_conditional_return_i(i).enter_rule(conditionalReturn)
          @topLevelConditionalReturns[conditionTest] = conditionalReturn

          if ctx.modl_top_level_conditional_return.size > ctx.modl_condition_test.size
            conditionTest = ParsedConditionTest.new
            conditionalReturn = ParsedTopLevelConditionalReturn.new
            ctx.modl_top_level_conditional_return_i(ctx.modl_top_level_conditional_return.size - 1).enter_rule(conditionalReturn)
            @topLevelConditionalReturns[conditionTest] = conditionalReturn
          end
          i += 1
        end
      end
    end

    class ParsedArrayConditionalReturn < Modl::Parser::MODLParserBaseListener
      attr_reader :arrayItems

      def initialize
        @arrayItems = []
      end

      def enterModl_array_conditional_return(ctx)
        unless ctx.modl_array_item.empty?
          # ctx.modl_array_item.forEach(ai ->
          ctx.modl_array_item.each do |ai|
            arrayItem = ParsedArrayItem.new
            ai.enter_rule(arrayItem)
            @arrayItems << arrayItem
          end
        end
      end
    end

    class ParsedArrayConditional < Modl::Parser::MODLParserBaseListener
      attr_reader :arrayConditionalReturns

      def initialize
        @arrayConditionalReturns = {}
      end

      def enterModl_array_conditional(ctx)
        i = 0
        while i < ctx.modl_condition_test.size
          conditionTest = ParsedConditionTest.new
          ctx.modl_condition_test_i(i).enter_rule(conditionTest)

          conditionalReturn = ParsedArrayConditionalReturn.new
          ctx.modl_array_conditional_return_i(i).enter_rule(conditionalReturn)
          @arrayConditionalReturns[conditionTest] = conditionalReturn

          if ctx.modl_array_conditional_return.size > ctx.modl_condition_test.size
            conditionTest = ParsedConditionTest.new
            conditionalReturn = ParsedArrayConditionalReturn.new
            ctx.modl_array_conditional_return_i(ctx.modl_array_conditional_return.size - 1).enter_rule(conditionalReturn)
            @arrayConditionalReturns[conditionTest] = conditionalReturn
          end
          i += 1
        end
      end
    end

    class ParsedValueConditionalReturn < Modl::Parser::MODLParserBaseListener
      attr_reader :valueItems

      def initialize
        @valueItems = []
      end

      def enterModl_value_conditional_return(ctx)
        unless ctx.modl_value_item.empty?
          # ctx.modl_value_item.forEach(vi ->
          ctx.modl_value_item.each do |vi|
            valueItem = ParsedValueItem.new
            vi.enter_rule(valueItem)
            @valueItems << valueItem
          end
        end
      end
    end

    class ParsedValueConditional < Modl::Parser::MODLParserBaseListener
      attr_reader :valueConditionalReturns

      def initialize
        @valueConditionalReturns = {}
      end

      def enterModl_value_conditional(ctx)
        i = 0
        while i < ctx.modl_condition_test.size
          conditionTest = ParsedConditionTest.new
          ctx.modl_condition_test_i(i).enter_rule(conditionTest)

          conditionalReturn = ParsedValueConditionalReturn.new
          ctx.modl_value_conditional_return_i(i).enter_rule(conditionalReturn)
          @valueConditionalReturns[conditionTest] = conditionalReturn

          if ctx.modl_value_conditional_return.size > ctx.modl_condition_test.size
            conditionTest = ParsedConditionTest.new
            conditionalReturn = ParsedValueConditionalReturn.new
            ctx.modl_value_conditional_return_i(ctx.modl_value_conditional_return.size - 1).enter_rule(conditionalReturn)
            @valueConditionalReturns[conditionTest] = conditionalReturn
          end
          i += 1
        end
      end
    end

    class ParsedNbArray < Modl::Parser::MODLParserBaseListener
      attr_reader :arrayItems

      def initialize
        @arrayItems = []
      end

      def extract_hash
        puts 'ParsedNbArray.extract_hash'

        result = []

        @arrayItems.each_index do |i|
          result << @arrayItems[i].extract_hash
        end

        result
      end

      def enterModl_nb_array(ctx)
        i = 0
        previous = nil
        ctx.children.each do |pt|
          if pt.is_a? MODLParser::Modl_array_itemContext
            arrayItem = ParsedArrayItem.new
            pt.enter_rule(arrayItem)
            @arrayItems[i] = arrayItem
            i += 1
          elsif pt.is_a? Antlr4::Runtime::TerminalNode
            if !previous.nil? && previous.is_a?(Antlr4::Runtime::TerminalNode) && pt.is_a?(Antlr4::Runtime::TerminalNode)
              # If we get here then we have two terminal nodes in a row, so we need to output something unless # the terminal symbols are newlines
              #
              prevSymbol = previous.symbol.type
              currentSymbol = pt.symbol.type

              if prevSymbol != MODLLexer::NEWLINE && currentSymbol != MODLLexer::NEWLINE
                arrayItem = Parsed.handleEmptyArrayItem
                @arrayItems[i] = arrayItem
                i += 1
              end
            end
          end
          previous = pt
        end
      end
    end

    def self.handleEmptyArrayItem
      # Create something for the blank array item
      #
      # The problem is that we might not have any context to tell us what type we need to create
      # so this currently defaults to the nil value
      #
      # TODO : Is there a way to know the type to create or is nil always acceptable?
      arrayItem = ParsedArrayItem.new
      arrayItem.arrayValueItem = ParsedArrayValueItem.new
      arrayItem.arrayValueItem.nilVal = ParsedNull.instance
      arrayItem
    end

    class ParsedArray < Modl::Parser::MODLParserBaseListener
      # We now have a list of < array_item | nbArray >
      attr_reader :abstractArrayItems

      def initialize
        @abstractArrayItems = []
      end

      def enterModl_array(ctx)
        # Create the new abstractArrayItems list first, sized to the total of array_item.size and nbArray.size
        i = 0
        previous = nil
        ctx.children.each do |pt|
          if pt.is_a? MODLParser::Modl_array_itemContext
            arrayItem = ParsedArrayItem.new
            pt.enter_rule(arrayItem)
            @abstractArrayItems[i] = arrayItem
            i += 1
          elsif pt.is_a? MODLParser::Modl_nb_arrayContext
            nbArray = ParsedNbArray.new
            pt.enter_rule(nbArray)
            @abstractArrayItems[i] = nbArray
            i += 1
          elsif pt.is_a? Antlr4::Runtime::TerminalNode
            if !previous.nil? && previous.is_a?(Antlr4::Runtime::TerminalNode) && pt.is_a?(Antlr4::Runtime::TerminalNode)

              # If we get here then we have two terminal nodes in a row, so we need to output something unless # the terminal symbols are newlines
              #
              prevSymbol = previous.symbol.type
              currentSymbol = pt.symbol.type

              if prevSymbol == MODLLexer::LSBRAC && currentSymbol == MODLLexer::RSBRAC
                next # This allows empty arrays
              end

              if prevSymbol != MODLLexer::NEWLINE && currentSymbol != MODLLexer::NEWLINE

                # Create something for the blank array item
                #
                # The problem is that we might not have any context to tell us what type we need to create
                # so this currently defaults to the nil
                #
                # TODO : Is there a way to know the type to create or is nil always acceptable?
                arrayItem = Parsed.handleEmptyArrayItem

                @abstractArrayItems[i] = arrayItem
                i += 1
              end
            end
          end
          previous = pt
        end
      end
    end

    class ParsedArrayItem < Modl::Parser::MODLParserBaseListener
      attr_accessor :arrayValueItem
      attr_accessor :arrayConditional

      def enterModl_array_item(ctx)
        unless ctx.modl_array_conditional.nil?
          @arrayConditional = ParsedArrayConditional.new
          ctx.modl_array_conditional.enter_rule(@arrayConditional)
        end
        unless ctx.modl_array_value_item.nil?
          @arrayValueItem = ParsedArrayValueItem.new
          ctx.modl_array_value_item.enter_rule(@arrayValueItem)
        end
      end

      def extract_hash
        puts 'ParsedArrayItem.extract_hash'

        return @arrayValueItem.extract_hash if @arrayValueItem
        return @arrayConditional.extract_hash if @arrayConditional
      end

    end

    class ParsedTrue < Modl::Parser::MODLParserBaseListener
      include Singleton
    end

    class ParsedFalse < Modl::Parser::MODLParserBaseListener
      include Singleton
    end

    class ParsedNull < Modl::Parser::MODLParserBaseListener
      include Singleton
    end

    def extract_json
      result = []
      if @structures.length > 0
        @structures.each do |s|
          value = s.extract_hash
          result << value unless value.nil?
        end
      else
        result = {}
      end
      if result.length == 1
        return result[0]
      end
      result
    end
  end
end