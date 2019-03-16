module Modl::Parser
  class Parsed < Modl::Parser::MODLParserBaseListener
    attr_reader :structures

    def initialize
      @structures = []
    end

    def enterModl(ctx)
      ctx.modl_structure.each do |str|
        structure = ParsedStructure.new
        str.enter_rule(structure)
        @structures << structure
      end
    end

    def exitModl(ctx)
      ;
    end

    def enterModl_structure(ctx)
      ;
    end

    def exitModl_structure(ctx)
      ;
    end

    def enterModl_map(ctx)
      ;
    end

    def exitModl_map(ctx)
      ;
    end

    def enterModl_array(ctx)
      ;
    end

    def exitModl_array(ctx)
      ;
    end

    def enterModl_nb_array(ctx)
      ;
    end

    def exitModl_nb_array(ctx)
      ;
    end

    def enterModl_pair(ctx)
      ;
    end

    def exitModl_pair(ctx)
      ;
    end

    def enterModl_value_item(ctx)
      ;
    end

    def exitModl_value_item(ctx)
      ;
    end

    def enterModl_top_level_conditional(ctx)
      ;
    end

    def exitModl_top_level_conditional(ctx)
      ;
    end

    def enterModl_top_level_conditional_return(ctx)
      ;
    end

    def exitModl_top_level_conditional_return(ctx)
      ;
    end

    def enterModl_map_conditional(ctx)
      ;
    end

    def exitModl_map_conditional(ctx)
      ;
    end

    def enterModl_map_conditional_return(ctx)
      ;
    end

    def exitModl_map_conditional_return(ctx)
      ;
    end

    def enterModl_map_item(ctx)
      ;
    end

    def exitModl_map_item(ctx)
      ;
    end

    def enterModl_array_conditional(ctx)
      ;
    end

    def exitModl_array_conditional(ctx)
      ;
    end

    def enterModl_array_conditional_return(ctx)
      ;
    end

    def exitModl_array_conditional_return(ctx)
      ;
    end

    def enterModl_array_item(ctx)
      ;
    end

    def exitModl_array_item(ctx)
      ;
    end

    def enterModl_value_conditional(ctx)
      ;
    end

    def exitModl_value_conditional(ctx)
      ;
    end

    def enterModl_value_conditional_return(ctx)
      ;
    end

    def exitModl_value_conditional_return(ctx)
      ;
    end

    def enterModl_condition_test(ctx)
      ;
    end

    def exitModl_condition_test(ctx)
      ;
    end

    def enterModl_operator(ctx)
      ;
    end

    def exitModl_operator(ctx)
      ;
    end

    def enterModl_condition(ctx)
      ;
    end

    def exitModl_condition(ctx)
      ;
    end

    def enterModl_condition_group(ctx)
      ;
    end

    def exitModl_condition_group(ctx)
      ;
    end

    def enterModl_value(ctx)
      ;
    end

    def exitModl_value(ctx)
      ;
    end

    def enterModl_array_value_item(ctx)
      ;
    end

    def exitModl_array_value_item(ctx)
      ;
    end

    def enterEveryRule(ctx)
      ;
    end

    def exitEveryRule(ctx)
      ;
    end

    def visitTerminal(node)
      ;
    end

    def visitErrorNode(node)
      ;
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
    end

    class ParsedMapItem < Modl::Parser::MODLParserBaseListener
      attr_reader :pair
      attr_reader :mapConditional

      def enterModl_map_item(ctx)
        if ctx.modl_pair != nil
          @pair = ParsedPair.new
          ctx.modl_pair().enter_rule(@pair)
        end
        if ctx.modl_map_conditional != nil
          @mapConditional = ParsedMapConditional.new
          ctx.modl_map_conditional().enter_rule(@mapConditional)
        end
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
    end

    class ParsedPair < Modl::Parser::MODLParserBaseListener
      attr_reader :key
      attr_reader :map
      attr_reader :array
      attr_reader :valueItem

      def enterModl_pair(ctx)
        @key = ctx.STRING.to_s unless ctx.STRING.nil?
        unless ctx.QUOTED.nil?
          @key = ctx.QUOTED.to_s
          @key = key.slice(1, key.length - 1)
        end
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

      def enterModl_array_value_item(ctx)
        if !ctx.NUMBER.nil?
          @number = ParsedNumber.new(ctx.NUMBER.text)
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
          textValue = Parsed.additionalStringProcessing(ctx.STRING.text)
          @string = ParsedString.new(textValue)
        elsif !ctx.QUOTED.nil?
          textValue = additionalStringProcessing(ctx.QUOTED.text)
          @quoted = ParsedQuoted.new(textValue)
        elsif !ctx.Null.nil?
          @nilVal = ParsedNull.instance
        elsif !ctx.TRUE.nil?
          @trueVal = ParsedTrue.instance
        elsif !ctx.FALSE.nil?
          @falseVal = ParsedFalse.instance
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

      def enterModl_value(ctx)
        if !ctx.NUMBER.nil?
          @number = ParsedNumber.new(ctx.NUMBER.text)
        elsif !ctx.modl_map.nil?
          @map = ParsedMap.new
          ctx.modl_map.enter_rule(map)
        elsif !ctx.modl_nb_array.nil?
          @nbArray = ParsedNbArray.new
          ctx.modl_nb_array.enter_rule(nbArray)
        elsif !ctx.modl_array.nil?
          @array = ParsedArray.new
          ctx.modl_array.enter_rule(array)
        elsif !ctx.modl_pair.nil?
          @pair = ParsedPair.new
          ctx.modl_pair.enter_rule(pair)
        elsif !ctx.STRING.nil?
          textValue = Parsed.additionalStringProcessing(ctx.STRING.text)
          @string = ParsedString.new(textValue)
        elsif !ctx.QUOTED.nil?
          textValue = Parsed.additionalStringProcessing(ctx.QUOTED.text)
          @quoted = ParsedQuoted.new(textValue)
        elsif !ctx.nil.nil?
          @nilVal = ParsedNull.instance
        elsif !ctx.TRUE.nil?
          @trueVal = ParsedTrue.instance
        elsif !ctx.FALSE.nil?
          @falseVal = ParsedFalse.instance
        end
        # ignoring comments!
      end
    end

    class ParsedString
      attr_reader :string

      def initialize(string)
        @string = string
      end
    end

    class ParsedNumber
      attr_reader :string

      def initialize(string)
        @string = string
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
  end
end