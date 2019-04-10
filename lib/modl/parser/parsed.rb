require 'modl/parser/MODLParserBaseListener'
require 'modl/parser/global_parse_context'
require 'modl/parser/ref_processor'
require 'modl/parser/substitutions'
require 'modl/parser/file_importer'
require 'antlr4/runtime/parse_cancellation_exception'
require 'cgi'
require 'net/http'

module Modl::Parser
  class Parsed < Modl::Parser::MODLParserBaseListener
    attr_reader :structures
    attr_reader :global

    def initialize(global = nil)
      @global = global
      @structures = []
    end

    def enterModl(ctx)

      @global = GlobalParseContext.new if @global.nil?

      ctx.modl_structure.each do |str|
        structure = ParsedStructure.new @global
        str.enter_rule(structure)
        @structures << structure
      end

      @global
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
      text = Substitutions.instance.process text
      # Special case for a possibly empty graved string ``
      unless text.nil?
        matchData = /^`([^`]*)`$/.match text
        return matchData[1] if matchData && matchData.length > 0
      end
      text
    end

    class ParsedMap < Modl::Parser::MODLParserBaseListener
      attr_reader :mapItems

      def initialize(global)
        @global = global
      end

      def enterModl_map(ctx)
        if ctx.modl_map_item != nil
          @mapItems = []
          ctx.modl_map_item.each do |mi|
            mapItem = ParsedMapItem.new @global
            mi.enter_rule(mapItem)
            @mapItems << mapItem
          end
        end
      end

      def extract_hash
        result = {}
        mapItems.each do |i|
          i_hash = i.extract_hash
          if i_hash.is_a? Hash
            i_hash.keys.each do |k|
              result[k] = i_hash[k]
            end
          end
        end
        if result.is_a?(Array) && result.length == 1
          return result[0]
        end
        result
      end

    end

    class ParsedMapItem < Modl::Parser::MODLParserBaseListener
      attr_reader :pair
      attr_reader :mapConditional

      def initialize(global)
        @global = global
      end

      def enterModl_map_item(ctx)
        if ctx.modl_pair() != nil
          @pair = ParsedPair.new @global
          ctx.modl_pair().enter_rule(@pair)
        end
        if ctx.modl_map_conditional != nil
          @mapConditional = ParsedMapConditional.new @global
          ctx.modl_map_conditional.enter_rule(@mapConditional)
        end
      end

      def extract_hash
        return @pair.extract_hash if @pair
        return @mapConditional.extract_hash if @mapConditional
      end

    end

    class ParsedStructure < Modl::Parser::MODLParserBaseListener
      attr_reader :array
      attr_reader :pair
      attr_reader :top_level_conditional
      attr_reader :map

      def initialize(global)
        @global = global
      end

      def enterModl_structure(ctx)
        if !ctx.modl_pair.nil?
          @pair = ParsedPair.new @global
          ctx.modl_pair.enter_rule(@pair)
        elsif !ctx.modl_top_level_conditional.nil?
          @top_level_conditional = ParsedTopLevelConditional.new @global
          ctx.modl_top_level_conditional.enter_rule(@top_level_conditional)
        elsif !ctx.modl_map.nil?
          @map = ParsedMap.new @global
          ctx.modl_map.enter_rule(@map)
        elsif !ctx.modl_array.nil?
          @array = ParsedArray.new @global
          ctx.modl_array.enter_rule(@array)
        end
      end

      def extract_hash
        return @array.extract_hash if @array
        return @pair.extract_hash if @pair
        return @top_level_conditional.extract_hash if @top_level_conditional
        return @map.extract_hash if @map
      end
    end

    class ParsedPair < Modl::Parser::MODLParserBaseListener
      attr_accessor :key
      attr_accessor :map
      attr_accessor :array
      attr_accessor :valueItem
      attr_accessor :key_lists
      attr_accessor :type # A string set to the type of pair that we have found bases on its key
      attr_accessor :text # The simple text value rather than the object
      attr_reader :final

      def initialize(global)
        @global = global
        @needs_defref = true
        @final = false
      end

      def set_value value
        if value.is_a? Array
          @map = nil
          @array = ParsedArray.new @global
          @array.abstractArrayItems = []
          value.each do |item|
            arrayItem = ParsedArrayItem.new @global
            arrayItem.arrayValueItem = ParsedArrayValueItem.new @global
            arrayItem.arrayValueItem.string = ParsedString.new(item)
            arrayItem.arrayValueItem.text = item
            @array.abstractArrayItems << arrayItem
          end
          @valueItem = nil
          @text = @array.extract_hash
          return
        end
        if value.is_a?(TrueClass) || value.is_a?(FalseClass)
          @map = nil
          @array = nil
          @valueItem = ParsedValueItem.new @global
          @valueItem.value = ParsedValue.new @global
          if value
            @valueItem.value.trueVal = ParsedTrue.instance
          else
            @valueItem.value.falseVal = ParsedFalse.instance
          end
          @valueItem.value.text = value
          @text = value
          return
        end
        value = value.extract_hash unless value.is_a?(String) || value.is_a?(Fixnum)
        @map = nil
        @array = nil
        @valueItem = ParsedValueItem.new @global
        @valueItem.value = ParsedString.new(value)
        @text = value
      end

      def extract_hash

        value = @array.extract_hash if @array
        value = @valueItem.extract_hash if @valueItem
        value = @map.extract_hash if @map

        unless value.is_a?(String) && value.start_with?('%')
          @text = value
          {@key => value}
        end

        return if @type == 'index'
        return if @type == 'hidden'
        return if @type == 'version'
        return if @type == 'class'
        return if @type == 'method'
        return if @type == 'import'

        {@key => @text}
      end

      def enterModl_pair(ctx)
        @type = 'pair'

        @key = ctx.STRING.to_s unless ctx.STRING.nil?
        unless ctx.QUOTED.nil?
          @key = ctx.QUOTED.to_s
          @key = key.slice(1, key.length - 2) # remove the quotes
        end

        @type = 'class' if @key == '*c' || @key == '*class'
        if @key == '*C' || @key == '*CLASS'
          @type = 'class'
          @key = @key.downcase
          @final = true
        end
        @type = 'id' if @key == '*i' || @key == '*id'
        @type = 'name' if @key == '*n' || @key == '*name'
        @type = 'name' if @key == '*N' || @key == '*NAME'
        @type = 'superclass' if @key == '*S' || @key == '*SUPERCLASS'
        @type = 'superclass' if @key == '*s' || @key == '*superclass'
        @type = 'keylist' if @key == '*a' || @key == '*assign'
        @type = 'version' if @key == '*V' || @key == '*VERSION'
        @type = 'method' if @key == '*m' || @key == '*method'
        @type = 'transform' if @key == '*t' || @key == '*transform'
        if @key == '*L' || @key == '*LOAD'
          @key = @key.downcase
          @type = 'import'
          @final = true
        end
        if @key == '*l' || @key == '*load'
          @type = 'import'
        end
        @type = 'index' if @key == '?'
        @type = 'hidden' if @key.start_with? '_'

        raise Antlr4::Runtime::ParseCancellationException, 'Invalid keyword: ' + @key if @type == 'pair' && @key.start_with?('*')

        if !ctx.modl_array.nil?
          @array = ParsedArray.new @global
          ctx.modl_array.enter_rule(@array)
        elsif !ctx.modl_map.nil?
          @map = ParsedMap.new @global
          ctx.modl_map.enter_rule(@map)
        elsif !ctx.modl_value_item.nil?
          @valueItem = ParsedValueItem.new @global
          ctx.modl_value_item.enter_rule(@valueItem)
        end

        validate_key if @type == 'pair' || @type == 'hidden'

        # Type-specific processing
        case @type
        when 'class'
          extract_class
        when 'id'
          extract_value
        when 'name'
          extract_value
        when 'superclass'
          extract_value
        when 'keylist'
          extract_key_list @valueItem if @valueItem
          extract_key_list @array if @array
        when 'version'
          extract_value
        when 'method'
          extract_method
        when 'transform'
          extract_transform @valueItem
        when 'import'
          files = @valueItem.extract_hash if @valueItem
          files = @array.extract_hash if @array
          FileImporter.instance.import_files files, @global
        when 'index'
          extract_index
        when 'hidden'
          extract_value
          invoke_deref
        else
          extract_value
          invoke_deref
        end

        return if @global.conditional > 0 # Don't store pairs in conditionals until we evaluate the conditions

        if @key.start_with? '_'
          k = @key.slice(1, @key.length)
          existing = @global.pairs[k]
          raise Antlr4::Runtime::ParseCancellationException, "Already defined " + k + " as final." if existing && existing.final
          @global.pairs[k] = self
        end
        existing = @global.pairs[@key]
        raise Antlr4::Runtime::ParseCancellationException, "Already defined " + @key + " as final." if existing && existing.final
        @global.pairs[@key] = self
      end

      def extract_class
        if @type == 'class'
          clazz = {}
          map = @map if @map
          map = @valueItem&.value&.map if @valueItem&.value&.map

          map.mapItems.each do |item|
            if item&.pair&.type
              case item&.pair&.type
              when 'id'
                clazz['id'] = item.pair.valueItem.value.string.string
              when 'name'
                clazz['name'] = item.pair.valueItem.value.string.string
              when 'superclass'
                clazz['superclass'] = item.pair.valueItem.value.string.string
              when 'keylist'
                clazz['keylist'] = item.pair.key_lists
              else
                clazz[item.pair.key] = item.pair.array if item.pair.array
                clazz[item.pair.key] = item.pair.map if item.pair.map
                clazz[item.pair.key] = item.pair.valueItem.value if item.pair.valueItem.value
              end
            end
          end

          superclass = clazz['superclass']
          if superclass && !(superclass == 'map' || superclass == 'str' || superclass == 'arr' || superclass == 'num') && !@global.classes.keys.include?(superclass)
            raise Antlr4::Runtime::ParseCancellationException, 'Invalid superclass: ' + superclass.to_s
          end
          raise Antlr4::Runtime::ParseCancellationException, 'Missing id for class' if clazz['id'].nil?

# store the classes by id and name to make them easier to find later
          @global.classes[clazz['id']] = clazz
          @global.classes[clazz['name']] = clazz
        end
      end

      def extract_method
        if @type == 'method'
          mthd = {}
          map = @map if @map
          map = @valueItem&.value&.map if @valueItem&.value&.map

          map.mapItems.each do |item|
            if item&.pair&.type
              case item&.pair&.type
              when 'id'
                mthd['id'] = item.pair.valueItem.value.string.string
              when 'transform'
                mthd['transform'] = item.pair.valueItem.value.string.string
              when 'name'
                mthd['name'] = item.pair.valueItem.value.string.string
              else
                raise Antlr4::Runtime::ParseCancellationException, 'Invalid *method - only *id, *name, and *transform fields expected'
              end
            end
          end

          raise Antlr4::Runtime::ParseCancellationException, 'Missing id for method' if mthd['id'].nil?
          raise Antlr4::Runtime::ParseCancellationException, 'Missing name for method' if mthd['name'].nil?

# Does the method name or id already exist?
          raise Antlr4::Runtime::ParseCancellationException, 'Duplicate method name: ' + mthd['name'] unless @global.methods_hash[mthd['name']].nil?
          raise Antlr4::Runtime::ParseCancellationException, 'Duplicate method id: ' + mthd['id'] unless @global.methods_hash[mthd['id']].nil?


# store the methods by id and name to make them easier to find later
          @global.methods_hash[mthd['id']] = mthd
          @global.methods_hash[mthd['name']] = mthd
        end
      end

      def extract_value
        item = @valueItem
        @text = item.value.text if item.is_a?(ParsedValueItem) && item.value
        @text = item.valueItem.value.text if item.is_a?(ParsedPair)
        invoke_deref
      end

      def extract_index
        item = @valueItem if @valueItem
        item = @array if @array

        # collect all values from the object
        if item.is_a? ParsedValueItem
          if item&.value&.text
            @global.index << item.value.text
          elsif item&.value&.array
            item.value.array.abstractArrayItems.each do |avi|
              @global.index << avi.arrayValueItem
            end
          elsif item&.value&.nbArray
            item.value.nbArray.arrayItems.each do |avi|
              @global.index << avi.arrayValueItem
            end
          end
          return
        elsif item.is_a? ParsedArray
          item.abstractArrayItems.each do |avi|
            @global.index << avi.arrayValueItem
          end
          return
        else
          return
        end
        raise Antlr4::Runtime::ParseCancellationException, 'The index should have one or more values'
      end

      def extract_key_list item
        # the item must be an array of arrays
        @key_lists = []
        if item.is_a?(ParsedValueItem) && item.value.is_a?(ParsedValue) && item.value.array
          item.value.array.abstractArrayItems.each do |avi|
            key_list = []
            avi.arrayValueItem.array.abstractArrayItems.each do |key|
              key_list << key.arrayValueItem.string.string if key.arrayValueItem.string
              key_list << key.arrayValueItem.number.num if key.arrayValueItem.number
            end
            @key_lists << key_list
          end
        elsif item.is_a?(ParsedArray)
          item.abstractArrayItems.each do |avi|
            key_list = []
            avi.arrayValueItem.array.abstractArrayItems.each do |key|
              key_list << key.arrayValueItem.string.string if key.arrayValueItem.string
              key_list << key.arrayValueItem.number.num if key.arrayValueItem.number
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

      def validate_key
        invalid_chars = "!$@-+'*#^&%"
        invalid_chars.each_char do |c|
          if @key.include?(c)
            if c == '%' && @key.rindex(c) == 0
              next
            end
            raise Antlr4::Runtime::ParseCancellationException, 'Invalid key - "' + c + '" character not allowed: ' + @key
          end
        end

        key = (@key.start_with?('_')) ? @key.slice(1, @key.length) : @key

        if key == key.to_i.to_s
          raise Antlr4::Runtime::ParseCancellationException, 'Invalid key - "' + key + '" - entirely numeric keys are not allowed: ' + @key
        end

      end

      def invoke_deref
        if @needs_defref && !@text.nil? && @text.is_a?(String) && @text.include?('%')
          @needs_defref = false

          @text, new_value = RefProcessor.instance.deref @text, @global

          if new_value.is_a? ParsedMap
            @map = new_value
          elsif new_value.is_a? ParsedArray
            @array = new_value
          elsif new_value.is_a? ParsedValueItem
            @valueItem = new_value
          elsif new_value.nil?
            set_value @text
          elsif new_value.is_a? ParsedPair
            set_value @text
          end
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
      attr_accessor :string
      attr_accessor :text # The simple text value rather than the object

      def initialize(global)
        @global = global
      end

      def extract_hash
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
          @map = ParsedMap.new @global
          ctx.modl_map.enter_rule(@map)
        elsif !ctx.modl_array.nil?
          @array = ParsedArray.new @global
          ctx.modl_array.enter_rule(@array)
        elsif !ctx.modl_pair.nil?
          @pair = ParsedPair.new @global
          ctx.modl_pair.enter_rule(@pair)
        elsif !ctx.STRING.nil?
          @text = Parsed.additionalStringProcessing(ctx.STRING.text)
          @text, new_value = RefProcessor.instance.deref @text, @global
          @string = ParsedString.new(@text)
        elsif !ctx.QUOTED.nil?
          @text = ctx.QUOTED.text.slice(1, ctx.QUOTED.text.length - 2) # remove the quotes
          @text = Parsed.additionalStringProcessing(@text)
          @text, new_value = RefProcessor.instance.deref @text, @global
          @quoted = ParsedQuoted.new(@text)
        elsif !ctx.Null.nil?
          @nilVal = ParsedNull.instance
          @text = 'null'
        elsif !ctx.TRUE.nil?
          @trueVal = ParsedTrue.instance
          @text = true
        elsif !ctx.FALSE.nil?
          @falseVal = ParsedFalse.instance
          @text = false
        end

        # ignoring comments!
      end
    end

    class ParsedValueItem < Modl::Parser::MODLParserBaseListener
      attr_accessor :value
      attr_reader :valueConditional

      def initialize(global)
        @global = global
      end

      def enterModl_value_item(ctx)
        unless ctx.modl_value_conditional.nil?
          @valueConditional = ParsedValueConditional.new @global
          ctx.modl_value_conditional.enter_rule(@valueConditional)
        end
        unless ctx.modl_value.nil?
          @value = ParsedValue.new @global
          ctx.modl_value.enter_rule(@value)
        end
      end

      def extract_hash
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
      attr_accessor :trueVal
      attr_accessor :falseVal
      attr_reader :nilVal
      attr_reader :string
      attr_accessor :text # The simple text value rather than the object

      def initialize(global)
        @global = global
      end

      def extract_hash
        return @map.extract_hash if @map
        return @array.extract_hash if @array
        return @nbArray.extract_hash if @nbArray
        return @pair.extract_hash if @pair

        @text
      end

      def evaluate
        return false if @nilVal
        return false if @falseVal
        true
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
          @map = ParsedMap.new @global
          ctx.modl_map.enter_rule(@map)
        elsif !ctx.modl_nb_array.nil?
          @nbArray = ParsedNbArray.new @global
          ctx.modl_nb_array.enter_rule(@nbArray)
        elsif !ctx.modl_array.nil?
          @array = ParsedArray.new @global
          ctx.modl_array.enter_rule(@array)
        elsif !ctx.modl_pair.nil?
          @pair = ParsedPair.new @global
          ctx.modl_pair.enter_rule(@pair)
        elsif !ctx.STRING.nil?
          @text = Parsed.additionalStringProcessing(ctx.STRING.text)
          @string = ParsedString.new(@text)
        elsif !ctx.QUOTED.nil?
          @text = ctx.QUOTED.text.slice(1, ctx.QUOTED.text.length - 2) # remove the quotes
          @text = Parsed.additionalStringProcessing(@text)
          @quoted = ParsedQuoted.new(@text)
        elsif !ctx.NULL.nil?
          @nilVal = ParsedNull.instance
          @text = nil
        elsif !ctx.TRUE.nil?
          @trueVal = ParsedTrue.instance
          @text = true
        elsif !ctx.FALSE.nil?
          @falseVal = ParsedFalse.instance
          @text = false
        end
        # ignoring comments!
      end
    end

    class ParsedString
      attr_reader :string

      def initialize(string)
        @string = string
      end

      def text
        @string
      end

      def extract_hash
        @string
      end
    end

    class ParsedNumber
      attr_reader :num

      def initialize(string)
        if string.include? '.'
          @num = string.to_f
        else
          @num = string.to_i
        end
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

      def initialize(global)
        @global = global
        @subConditionList = []
      end

      def evaluate
        result = false
        @subConditionList.each do |s|
          last_operator = s.b.a
          should_negate = s.b.b

          partial = s.a.evaluate
          result |= (should_negate) ? !partial : partial
        end
        result
      end

      def enterModl_condition_test(ctx)
        unless ctx.children.empty?
          lastOperator = nil
          shouldNegate = false
          ctx.children.each do |child|
            if child.is_a? MODLParser::Modl_condition_groupContext
              conditionGroup = ParsedConditionGroup.new @global
              child.enter_rule(conditionGroup)

              p2 = OpenStruct.new
              p2.a = lastOperator
              p2.b = shouldNegate

              p1 = OpenStruct.new
              p1.a = conditionGroup
              p1.b = p2

              @subConditionList << p1

              lastOperator = nil
              shouldNegate = false
            elsif child.is_a? MODLParser::Modl_conditionContext
              condition = ParsedCondition.new @global
              child.enter_rule(condition)
              p2 = OpenStruct.new
              p2.a = lastOperator
              p2.b = shouldNegate

              p1 = OpenStruct.new
              p1.a = condition
              p1.b = p2

              @subConditionList << p1

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

      def initialize(global)
        @global = global
        @conditionsTestList = []
      end

      def evaluate
        result = false
        @conditionsTestList.each do |s|
          last_operator = s.b

          partial = s.a.evaluate
          result |= partial
        end
        result
      end

      def enterModl_condition_group(ctx)
        unless ctx.children.empty?
          lastOperator = nil
          ctx.children.each do |child|
            if child.is_a? MODLParser::Modl_condition_testContext
              conditionTest = ParsedConditionTest.new @global
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

      def initialize(global)
        @global = global
        @values = []
      end

      def evaluate
        result = false
        if @key
          key = (@key.start_with?('%')) ? @key.slice(1, @key.length) : @key
          ikey = key.to_i
          if ikey.to_s == key
            value1 = @global.index[ikey].text
          else
            pair = @global.pairs[key]
            return false unless pair
            value1 = pair.text
          end

          @values.each do |value|
            value2 = value.text
            value2 = @global.pairs[value.text].text if @global.pairs[value.text]

            case @operator
            when '='
              wild = (value2.is_a?(String) && value2.include?('*')) ? true : false
              if wild
                regex = '^'
                value2.each_char do |c|
                  if c == '*'
                    regex << '.*'
                  else
                    regex << c
                  end
                end
                result |= !(value1.match(regex).nil?)
              else
                result |= value1 == value2
              end
            when '>'
              result |= value1 > value2
            when '<'
              result |= value1 < value2
            when '>='
              result |= value1 >= value2
            when '<='
              result |= value1 <= value2
            end
            break if result # shortcut if we have a matching value
          end
        elsif @values.length == 1
          key = @values[0].text
          if key.is_a?(String)
            key = (key.start_with?('%')) ? key.slice(1, key.length) : key
          end
          the_pair = @global.pairs[key]
          if the_pair
            result = the_pair.text
          else
            if @values[0].trueVal
              return true
            elsif @values[0].falseVal
              return false
            elsif @values[0].string
              return false
            end
            result = @values[0].evaluate
          end
        end
        result
      end

      def enterModl_condition(ctx)
        @key = ctx.STRING.text unless ctx.STRING.nil?
        @operator = ctx.modl_operator.text unless ctx.modl_operator.nil?
        ctx.modl_value.each do |v|
          value = ParsedValue.new @global
          v.enter_rule(value)
          @values << value
        end
      end
    end

    class ParsedMapConditionalReturn < Modl::Parser::MODLParserBaseListener
      attr_reader :mapItems

      def initialize(global)
        @global = global
        @mapItems = []
      end

      def extract_hash
        @mapItems[0].extract_hash
      end

      def enterModl_map_conditional_return(ctx)
        unless ctx.modl_map_item.empty?
          ctx.modl_map_item.each do |mi|
            mapItem = ParsedMapItem.new @global
            mi.enter_rule(mapItem)
            @mapItems << mapItem
          end
        end
      end
    end

    class ParsedMapConditional < Modl::Parser::MODLParserBaseListener
      attr_reader :conditionTests
      attr_reader :mapConditionalReturns

      def initialize(global)
        @global = global
        @conditionTests = []
        @mapConditionalReturns = []
      end

      def extract_hash
        result = @conditionTests[0].evaluate
        return @mapConditionalReturns[0].extract_hash if result
        @mapConditionalReturns[1].extract_hash
      end

      def enterModl_map_conditional(ctx)
        i = 0
        while i < ctx.modl_condition_test.size
          conditionTest = ParsedConditionTest.new @global
          ctx.modl_condition_test_i(i).enter_rule(conditionTest)

          conditionalReturn = ParsedMapConditionalReturn.new @global
          ctx.modl_map_conditional_return_i(i).enter_rule(conditionalReturn)
          @conditionTests[i] = conditionTest
          @mapConditionalReturns[i] = conditionalReturn

          if ctx.modl_map_conditional_return.size > ctx.modl_condition_test.size
            i += 1
            conditionalReturn = ParsedMapConditionalReturn.new @global
            ctx.modl_map_conditional_return_i(ctx.modl_map_conditional_return.size - 1).enter_rule(conditionalReturn)
            @mapConditionalReturns[i] = conditionalReturn
          end
          i += 1
        end
      end
    end

    class ParsedTopLevelConditionalReturn < Modl::Parser::MODLParserBaseListener
      attr_reader :structures

      def initialize(global)
        @global = global
        @structures = []
      end

      def extract_hash
        if @structures.length == 1
          return @structures[0].extract_hash
        else
          result = []
          @structures.each do |s|
            hash = s.extract_hash
            result << hash unless hash.nil?
          end
          return result unless result.length == 1
          return result[0] if result.length == 1
        end
      end

      def enterModl_top_level_conditional_return(ctx)
        unless ctx.modl_structure.empty?
          # ctx.modl_structure.forEach(str ->
          ctx.modl_structure.each do |str|
            structure = ParsedStructure.new @global
            str.enter_rule(structure)
            @structures << structure
          end
        end
      end
    end

    class ParsedTopLevelConditional < Modl::Parser::MODLParserBaseListener
      attr_reader :conditionTests
      attr_reader :topLevelConditionalReturns

      def initialize(global)
        @global = global
        @topLevelConditionalReturns = []
        @conditionTests = []
      end

      def extract_hash
        @conditionTests.each_index do |i|
          if @conditionTests[i].evaluate
            item = @topLevelConditionalReturns[i]
            if item.structures[0].pair
              key = item.structures[0].pair.key
              key = key.slice(1, key.length) if key[0] == '_'
              @global.pairs[key] = item.structures[0].pair
            end
            return item.extract_hash
          end
        end
        if @topLevelConditionalReturns.length > @conditionTests.length
          last_item = @topLevelConditionalReturns[-1]
          if last_item.structures[0].pair
            key = last_item.structures[0].pair.key
            key = key.slice(1, key.length) if key[0] == '_'
            @global.pairs[key] = last_item.structures[0].pair
          end
          return last_item.extract_hash
        end
      end

      def enterModl_top_level_conditional(ctx)
        @global.conditional += 1
        i = 0
        while i < ctx.modl_condition_test.size
          conditionTest = ParsedConditionTest.new @global
          ctx.modl_condition_test_i(i).enter_rule(conditionTest)

          conditionalReturn = ParsedTopLevelConditionalReturn.new @global
          ctx.modl_top_level_conditional_return_i(i).enter_rule(conditionalReturn)
          @conditionTests[i] = conditionTest
          @topLevelConditionalReturns[i] = conditionalReturn
          i += 1
        end
        if ctx.modl_top_level_conditional_return.size > ctx.modl_condition_test.size
          conditionalReturn = ParsedTopLevelConditionalReturn.new @global
          ctx.modl_top_level_conditional_return_i(ctx.modl_top_level_conditional_return.size - 1).enter_rule(conditionalReturn)
          @topLevelConditionalReturns[i] = conditionalReturn
        end
        @global.conditional -= 1
      end
    end

    class ParsedArrayConditionalReturn < Modl::Parser::MODLParserBaseListener
      attr_reader :arrayItems

      def initialize(global)
        @global = global
        @arrayItems = []
      end

      def extract_hash
        @arrayItems[0].arrayValueItem.text
      end

      def enterModl_array_conditional_return(ctx)
        unless ctx.modl_array_item.empty?
          # ctx.modl_array_item.forEach(ai ->
          ctx.modl_array_item.each do |ai|
            arrayItem = ParsedArrayItem.new @global
            ai.enter_rule(arrayItem)
            @arrayItems << arrayItem
          end
        end
      end
    end

    class ParsedArrayConditional < Modl::Parser::MODLParserBaseListener
      attr_reader :conditionTest
      attr_reader :arrayConditionalReturns

      def initialize(global)
        @global = global
        @conditionTests = []
        @arrayConditionalReturns = []
      end

      def extract_hash
        result = @conditionTests[0].evaluate
        return @arrayConditionalReturns[0].extract_hash if result
        @arrayConditionalReturns[1].extract_hash
      end

      def enterModl_array_conditional(ctx)
        i = 0
        while i < ctx.modl_condition_test.size
          conditionTest = ParsedConditionTest.new @global
          ctx.modl_condition_test_i(i).enter_rule(conditionTest)

          conditionalReturn = ParsedArrayConditionalReturn.new @global
          ctx.modl_array_conditional_return_i(i).enter_rule(conditionalReturn)
          @conditionTests[i] = conditionTest
          @arrayConditionalReturns[i] = conditionalReturn

          if ctx.modl_array_conditional_return.size > ctx.modl_condition_test.size
            i += 1
            conditionTest = ParsedConditionTest.new @global
            conditionalReturn = ParsedArrayConditionalReturn.new @global
            ctx.modl_array_conditional_return_i(ctx.modl_array_conditional_return.size - 1).enter_rule(conditionalReturn)
            @conditionTests[i] = conditionTest
            @arrayConditionalReturns[i] = conditionalReturn
          end


          i += 1
        end
      end
    end

    class ParsedValueConditionalReturn < Modl::Parser::MODLParserBaseListener
      attr_reader :valueItems

      def initialize(global)
        @global = global
        @valueItems = []
      end

      def extract_hash
        return @valueItems[0].value.text if @valueItems[0].value.text
        return @valueItems[0].value.extract_hash
      end

      def enterModl_value_conditional_return(ctx)
        unless ctx.modl_value_item.empty?
          # ctx.modl_value_item.forEach(vi ->
          ctx.modl_value_item.each do |vi|
            valueItem = ParsedValueItem.new @global
            vi.enter_rule(valueItem)
            @valueItems << valueItem
          end
        end
      end
    end

    class ParsedValueConditional < Modl::Parser::MODLParserBaseListener
      attr_reader :conditionTests
      attr_reader :valueConditionalReturns

      def initialize(global)
        @global = global
        @conditionTests = []
        @valueConditionalReturns = []
      end

      def extract_hash
        result = @conditionTests[0].evaluate

        return result if @valueConditionalReturns.length == 0
        return @valueConditionalReturns[0].extract_hash if result
        return @valueConditionalReturns[1].extract_hash
      end

      def enterModl_value_conditional(ctx)
        i = 0
        while i < ctx.modl_condition_test.size
          conditionTest = ParsedConditionTest.new @global
          ctx.modl_condition_test_i(i).enter_rule(conditionTest)

          @conditionTests[i] = conditionTest

          return if ctx.modl_value_conditional_return_i(i).nil?

          conditionalReturn = ParsedValueConditionalReturn.new @global

          ctx.modl_value_conditional_return_i(i).enter_rule(conditionalReturn)

          @valueConditionalReturns[i] = conditionalReturn

          if ctx.modl_value_conditional_return.size > ctx.modl_condition_test.size
            conditionTest = ParsedConditionTest.new @global
            conditionalReturn = ParsedValueConditionalReturn.new @global
            ctx.modl_value_conditional_return_i(ctx.modl_value_conditional_return.size - 1).enter_rule(conditionalReturn)
            @conditionTests[i + 1] = conditionTest
            @valueConditionalReturns[i + 1] = conditionalReturn
          end

          i += 1
        end
      end
    end

    class ParsedNbArray < Modl::Parser::MODLParserBaseListener
      attr_reader :arrayItems

      def initialize(global)
        @global = global
        @arrayItems = []
      end

      def extract_hash
        result = []

        @arrayItems.each do |i|
          result << i.extract_hash
        end

        result
      end

      def enterModl_nb_array(ctx)
        i = 0
        previous = nil
        ctx.children.each do |pt|
          if pt.is_a? MODLParser::Modl_array_itemContext
            arrayItem = ParsedArrayItem.new @global
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
      arrayItem = ParsedArrayItem.new @global
      arrayItem.arrayValueItem = ParsedArrayValueItem.new @global
      arrayItem.arrayValueItem.nilVal = ParsedNull.instance
      arrayItem
    end

    class ParsedArray < Modl::Parser::MODLParserBaseListener
      # We now have a list of < array_item | nbArray >
      attr_accessor :abstractArrayItems

      def initialize(global)
        @global = global
        @abstractArrayItems = []
      end

      def extract_hash
        result = []

        abstractArrayItems.each do |i|
          result << i.extract_hash
        end

        result
      end

      def enterModl_array(ctx)
        # Create the new abstractArrayItems list first, sized to the total of array_item.size and nbArray.size
        i = 0
        previous = nil
        ctx.children.each do |pt|
          if pt.is_a? MODLParser::Modl_array_itemContext
            arrayItem = ParsedArrayItem.new @global
            pt.enter_rule(arrayItem)
            @abstractArrayItems[i] = arrayItem
            i += 1
          elsif pt.is_a? MODLParser::Modl_nb_arrayContext
            nbArray = ParsedNbArray.new @global
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

      def initialize(global)
        @global = global
      end

      def enterModl_array_item(ctx)
        unless ctx.modl_array_conditional.nil?
          @arrayConditional = ParsedArrayConditional.new @global
          ctx.modl_array_conditional.enter_rule(@arrayConditional)
        end
        unless ctx.modl_array_value_item.nil?
          @arrayValueItem = ParsedArrayValueItem.new @global
          ctx.modl_array_value_item.enter_rule(@arrayValueItem)
        end
      end

      def extract_hash
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
      return '' if result.length == 0
      return result[0] if result.length == 1
      result
    end
  end
end