# Generated from MODLParser.g4 by ANTLR 4.7.2

require 'antlr4/runtime'

module Modl::Parser

@@theMODLParserListener = MODLParserListener.new
@@theMODLParserVisitor = MODLParserVisitor.new



class MODLParser < Antlr4::Runtime::Parser

	class << self
		@@_decisionToDFA = []
	end
	@@_sharedContextCache = Antlr4::Runtime::PredictionContextCache.new()
		WS=1
		NULL=2
		TRUE=3
		FALSE=4
  COLON = 5
  EQUALS = 6
  STRUCT_SEP = 7
  ARR_SEP = 8
		LBRAC=9
		RBRAC=10
		LSBRAC=11
		RSBRAC=12
		NUMBER=13
		COMMENT=14
		STRING=15
		HASH_PREFIX=16
		QUOTED=17
		GRAVED=18
		LCBRAC=19
		CWS=20
		QMARK=21
		FSLASH=22
		GTHAN=23
		LTHAN=24
		ASTERISK=25
		AMP=26
		PIPE=27
		EXCLAM=28
		CCOMMENT=29
		RCBRAC=30
		RULE_modl = 0
		RULE_modl_structure = 1
		RULE_modl_map = 2
		RULE_modl_array = 3
		RULE_modl_nb_array = 4
		RULE_modl_pair = 5
		RULE_modl_value_item = 6
		RULE_modl_top_level_conditional = 7
		RULE_modl_top_level_conditional_return = 8
		RULE_modl_map_conditional = 9
		RULE_modl_map_conditional_return = 10
		RULE_modl_map_item = 11
		RULE_modl_array_conditional = 12
		RULE_modl_array_conditional_return = 13
		RULE_modl_array_item = 14
		RULE_modl_value_conditional = 15
		RULE_modl_value_conditional_return = 16
		RULE_modl_condition_test = 17
		RULE_modl_operator = 18
		RULE_modl_condition = 19
		RULE_modl_condition_group = 20
		RULE_modl_value = 21
		RULE_modl_array_value_item = 22
		RULE_modl_primitive = 23

	@@ruleNames = [
			"modl", "modl_structure", "modl_map", "modl_array", "modl_nb_array", 
			"modl_pair", "modl_value_item", "modl_top_level_conditional", "modl_top_level_conditional_return", 
			"modl_map_conditional", "modl_map_conditional_return", "modl_map_item", 
			"modl_array_conditional", "modl_array_conditional_return", "modl_array_item", 
			"modl_value_conditional", "modl_value_conditional_return", "modl_condition_test", 
			"modl_operator", "modl_condition", "modl_condition_group", "modl_value", 
			"modl_array_value_item", "modl_primitive"
	]

	@@_LITERAL_NAMES = [
      nil, nil, nil, nil, nil, nil, nil, nil, "','", nil, nil, nil, nil, nil,
      nil, nil, nil, nil, nil, "'{'", nil, "'?'", "'/'", "'>'", "'<'", "'*'",
      "'&'", "'|'", "'!'", nil, "'}'"
	]

	@@_SYMBOLIC_NAMES = [
      nil, "WS", "NULL", "TRUE", "FALSE", "COLON", "EQUALS", "STRUCT_SEP",
      "ARR_SEP", "LBRAC", "RBRAC", "LSBRAC", "RSBRAC", "NUMBER", "COMMENT",
      "STRING", "HASH_PREFIX", "QUOTED", "GRAVED", "LCBRAC", "CWS", "QMARK",
      "FSLASH", "GTHAN", "LTHAN", "ASTERISK", "AMP", "PIPE", "EXCLAM", "CCOMMENT",
      "RCBRAC"
	]

	@@VOCABULARY =  Antlr4::Runtime::VocabularyImpl.new(@@_LITERAL_NAMES, @@_SYMBOLIC_NAMES)

	def get_vocabulary
		@@VOCABULARY
	end

	def getGrammarFileName()
	 return "MODLParser.g4"
	end

	def rule_names()
	 return @@ruleNames
	end

	def serialized_atn()
	 return @@_serializedATN
	end

	def atn()
	 return @@_ATN
	end

	def initialize( input)
		super(input)
		i = 0
		while i < @@_ATN.number_of_decisions()
			@@_decisionToDFA[i] = Antlr4::Runtime::DFA.new(@@_ATN.decision_state(i), i)
			i+=1
		end

		@_interp =  Antlr4::Runtime::ParserATNSimulator.new(self,@@_ATN,@@_decisionToDFA,@@_sharedContextCache)
	end

	 class ModlContext < Antlr4::Runtime::ParserRuleContext
		def modl_structure()
			return rule_contexts("Modl_structureContext")
		end
		def modl_structure_i( i)
			return rule_context("Modl_structureContext",i)
		end

    def EOF()
      return token(MODLParser::EOF, 0)
    end

    def STRUCT_SEP()
      return tokens(MODLParser::STRUCT_SEP)
    end

    def STRUCT_SEP_i(i)
      return token(MODLParser::STRUCT_SEP, i)
    end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl()
		_localctx =  ModlContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 0, RULE_modl)
		_la = 0
		begin
      _alt = 0
      @_state_number = 64
      @_err_handler.sync(self)
      case (@_interp.adaptive_predict(@_input, 3, @_ctx))
      when 1
        enter_outer_alt(_localctx, 1)


        @_state_number = 49
        @_err_handler.sync(self)
        _la = @_input.la(1)
        if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << LBRAC) | (1 << LSBRAC) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC))) != 0))

          @_state_number = 48
          modl_structure()
        end


      when 2
        enter_outer_alt(_localctx, 2)


        @_state_number = 51
        modl_structure()
        @_state_number = 56
        @_err_handler.sync(self);
        _alt = @_interp.adaptive_predict(@_input, 1, @_ctx)
        while (_alt != 2 && _alt != Antlr4::Runtime::ATN::INVALID_ALT_NUMBER)
          if (_alt == 1)


            @_state_number = 52
            match(STRUCT_SEP)
            @_state_number = 53
            modl_structure()
          end
          @_state_number = 58
          @_err_handler.sync(self)
          _alt = @_interp.adaptive_predict(@_input, 1, @_ctx)
        end
        @_state_number = 60
        @_err_handler.sync(self)
        _la = @_input.la(1)
        if (_la == STRUCT_SEP)

          @_state_number = 59
          match(STRUCT_SEP)
        end

        @_state_number = 62
        match(EOF)

      end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_structureContext < Antlr4::Runtime::ParserRuleContext
		def modl_map()
			return rule_context("Modl_mapContext",0)
		end
		def modl_array()
			return rule_context("Modl_arrayContext",0)
		end
		def modl_top_level_conditional()
			return rule_context("Modl_top_level_conditionalContext",0)
		end
		def modl_pair()
			return rule_context("Modl_pairContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_structure
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_structure(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_structure(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_structure(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_structure()
		_localctx =  Modl_structureContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 2, RULE_modl_structure)
		begin
      @_state_number = 70
			@_err_handler.sync(self)
			case (@_input.la(1))
			when MODLParser::LBRAC
				enter_outer_alt(_localctx, 1)

        @_state_number = 66
				modl_map()

			when MODLParser::LSBRAC
				enter_outer_alt(_localctx, 2)

        @_state_number = 67
				modl_array()

			when MODLParser::LCBRAC
				enter_outer_alt(_localctx, 3)

        @_state_number = 68
				modl_top_level_conditional()

			when MODLParser::STRING, MODLParser::QUOTED
				enter_outer_alt(_localctx, 4)

        @_state_number = 69
				modl_pair()
			else
				raise Antlr4::Runtime::NoViableAltException self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_mapContext < Antlr4::Runtime::ParserRuleContext
		def LBRAC()
		  return token(MODLParser::LBRAC, 0)
		end
		def RBRAC()
		  return token(MODLParser::RBRAC, 0)
		end
		def modl_map_item()
			return rule_contexts("Modl_map_itemContext")
		end
		def modl_map_item_i( i)
			return rule_context("Modl_map_itemContext",i)
		end

    def STRUCT_SEP()
      return tokens(MODLParser::STRUCT_SEP)
		end

    def STRUCT_SEP_i(i)
      return token(MODLParser::STRUCT_SEP, i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_map
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_map(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_map(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_map(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_map()
		_localctx =  Modl_mapContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 4, RULE_modl_map)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

      @_state_number = 72
			match(LBRAC)
      @_state_number = 81
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << STRING) | (1 << QUOTED) | (1 << LCBRAC))) != 0))

        @_state_number = 73
				modl_map_item()
        @_state_number = 78
				@_err_handler.sync(self)
				_la = @_input.la(1)
        while (_la == STRUCT_SEP)


          @_state_number = 74
          match(STRUCT_SEP)
          @_state_number = 75
					modl_map_item()
          @_state_number = 80
					@_err_handler.sync(self)
					_la = @_input.la(1)
        end
			end

      @_state_number = 83
			match(RBRAC)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_arrayContext < Antlr4::Runtime::ParserRuleContext
		def LSBRAC()
		  return token(MODLParser::LSBRAC, 0)
		end
		def RSBRAC()
		  return token(MODLParser::RSBRAC, 0)
		end
		def modl_array_item()
			return rule_contexts("Modl_array_itemContext")
		end
		def modl_array_item_i( i)
			return rule_context("Modl_array_itemContext",i)
		end
		def modl_nb_array()
			return rule_contexts("Modl_nb_arrayContext")
		end
		def modl_nb_array_i( i)
			return rule_context("Modl_nb_arrayContext",i)
		end

    def STRUCT_SEP()
      return tokens(MODLParser::STRUCT_SEP)
		end

    def STRUCT_SEP_i(i)
      return token(MODLParser::STRUCT_SEP, i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_array
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_array(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_array(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_array(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_array()
		_localctx =  Modl_arrayContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 6, RULE_modl_array)
		_la = 0
		begin
			_alt = 0
			enter_outer_alt(_localctx, 1)

      @_state_number = 85
			match(LSBRAC)
      @_state_number = 110
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << NULL) | (1 << TRUE) | (1 << FALSE) | (1 << LBRAC) | (1 << LSBRAC) | (1 << NUMBER) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC))) != 0))

        @_state_number = 88
				@_err_handler.sync(self)
        case (@_interp.adaptive_predict(@_input, 7, @_ctx))
        when 1

          @_state_number = 86
					modl_array_item()

        when 2

          @_state_number = 87
					modl_nb_array()

        end
        @_state_number = 107
				@_err_handler.sync(self)
				_la = @_input.la(1)
        while (_la == STRUCT_SEP)


          @_state_number = 91
          @_err_handler.sync(self)
					_la = @_input.la(1)
					loop do


            @_state_number = 90
            match(STRUCT_SEP)
            @_state_number = 93
            @_err_handler.sync(self)
						_la = @_input.la(1)
            break if (!(_la == STRUCT_SEP))
					end
          @_state_number = 97
					@_err_handler.sync(self)
          case (@_interp.adaptive_predict(@_input, 9, @_ctx))
          when 1

            @_state_number = 95
						modl_array_item()

          when 2

            @_state_number = 96
            modl_nb_array()

          end
          @_state_number = 102
					@_err_handler.sync(self);
          _alt = @_interp.adaptive_predict(@_input, 10, @_ctx)
          while (_alt != 2 && _alt != Antlr4::Runtime::ATN::INVALID_ALT_NUMBER)
            if (_alt == 1)


              @_state_number = 99
              match(STRUCT_SEP)
            end
            @_state_number = 104
						@_err_handler.sync(self)
            _alt = @_interp.adaptive_predict(@_input, 10, @_ctx)
					end
          @_state_number = 109
					@_err_handler.sync(self)
					_la = @_input.la(1)
        end
			end

      @_state_number = 112
			match(RSBRAC)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_nb_arrayContext < Antlr4::Runtime::ParserRuleContext
		def modl_array_item()
			return rule_contexts("Modl_array_itemContext")
		end
		def modl_array_item_i( i)
			return rule_context("Modl_array_itemContext",i)
		end
		def COLON()
		 return tokens(MODLParser::COLON)
		end
		def COLON_i( i)
			return token(MODLParser::COLON, i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_nb_array
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_nb_array(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_nb_array(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_nb_array(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_nb_array()
		_localctx =  Modl_nb_arrayContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 8, RULE_modl_nb_array)
		begin
			_alt = 0
			enter_outer_alt(_localctx, 1)

      @_state_number = 120
      @_err_handler.sync(self)
			_alt = 1
			loop do
				case (_alt)
				when 1


          @_state_number = 114
					modl_array_item()
          @_state_number = 116
          @_err_handler.sync(self)
					_alt = 1
					loop do
						case (_alt)
						when 1


              @_state_number = 115
							match(COLON)

						else
							raise Antlr4::Runtime::NoViableAltException self
						end
            @_state_number = 118
            @_err_handler.sync(self)
            _alt = @_interp.adaptive_predict(@_input, 13, @_ctx)
					    break if !( _alt!=2 && _alt!=Antlr4::Runtime::ATN::INVALID_ALT_NUMBER )
					end

				else
					raise Antlr4::Runtime::NoViableAltException self
				end
        @_state_number = 122
        @_err_handler.sync(self)
        _alt = @_interp.adaptive_predict(@_input, 14, @_ctx)
			    break if !( _alt!=2 && _alt!=Antlr4::Runtime::ATN::INVALID_ALT_NUMBER )
			end
      @_state_number = 127
			@_err_handler.sync(self);
      _alt = @_interp.adaptive_predict(@_input, 15, @_ctx)
			while ( _alt!=2 && _alt!=Antlr4::Runtime::ATN::INVALID_ALT_NUMBER )
				if ( _alt==1 )


          @_state_number = 124
					modl_array_item() 
				end
        @_state_number = 129
				@_err_handler.sync(self)
        _alt = @_interp.adaptive_predict(@_input, 15, @_ctx)
			end
      @_state_number = 131
			@_err_handler.sync(self)
      case (@_interp.adaptive_predict(@_input, 16, @_ctx))
      when 1

        @_state_number = 130
				match(COLON)

      end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_pairContext < Antlr4::Runtime::ParserRuleContext
		def EQUALS()
		  return token(MODLParser::EQUALS, 0)
		end
		def modl_value_item()
			return rule_context("Modl_value_itemContext",0)
		end
		def STRING()
		  return token(MODLParser::STRING, 0)
		end
		def QUOTED()
		  return token(MODLParser::QUOTED, 0)
		end
		def modl_map()
			return rule_context("Modl_mapContext",0)
		end
		def modl_array()
			return rule_context("Modl_arrayContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_pair
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_pair(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_pair(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_pair(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_pair()
		_localctx =  Modl_pairContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 10, RULE_modl_pair)
		_la = 0
		begin
      @_state_number = 140
			@_err_handler.sync(self)
      case (@_interp.adaptive_predict(@_input, 17, @_ctx))
      when 1
				enter_outer_alt(_localctx, 1)

        @_state_number = 133
				_la = @_input.la(1)
				if ( !(_la==STRING || _la==QUOTED) )
				@_err_handler.recover_in_line(self)

				else
					if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
					  @matchedEOF = true
					end
					@_err_handler.report_match(self)
					consume()
				end
        @_state_number = 134
        match(EQUALS)
        @_state_number = 135
				modl_value_item()

      when 2
				enter_outer_alt(_localctx, 2)

        @_state_number = 136
				match(STRING)
        @_state_number = 137
				modl_map()

      when 3
				enter_outer_alt(_localctx, 3)

        @_state_number = 138
        match(STRING)
        @_state_number = 139
				modl_array()

      end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_value_itemContext < Antlr4::Runtime::ParserRuleContext
		def modl_value()
			return rule_context("Modl_valueContext",0)
		end
		def modl_value_conditional()
			return rule_context("Modl_value_conditionalContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_value_item
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_value_item(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_value_item(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_value_item(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_value_item()
		_localctx =  Modl_value_itemContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 12, RULE_modl_value_item)
		begin
			enter_outer_alt(_localctx, 1)

      @_state_number = 144
			@_err_handler.sync(self)
      case (@_interp.adaptive_predict(@_input, 18, @_ctx))
      when 1

        @_state_number = 142
				modl_value()

      when 2

        @_state_number = 143
				modl_value_conditional()

      end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_top_level_conditionalContext < Antlr4::Runtime::ParserRuleContext
		def LCBRAC()
		  return token(MODLParser::LCBRAC, 0)
		end
		def modl_condition_test()
			return rule_contexts("Modl_condition_testContext")
		end
		def modl_condition_test_i( i)
			return rule_context("Modl_condition_testContext",i)
		end
		def QMARK()
		 return tokens(MODLParser::QMARK)
		end
		def QMARK_i( i)
			return token(MODLParser::QMARK, i)
		end
		def modl_top_level_conditional_return()
			return rule_contexts("Modl_top_level_conditional_returnContext")
		end
		def modl_top_level_conditional_return_i( i)
			return rule_context("Modl_top_level_conditional_returnContext",i)
		end
		def RCBRAC()
		  return token(MODLParser::RCBRAC, 0)
		end
		def FSLASH()
		 return tokens(MODLParser::FSLASH)
		end
		def FSLASH_i( i)
			return token(MODLParser::FSLASH, i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_top_level_conditional
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_top_level_conditional(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_top_level_conditional(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_top_level_conditional(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_top_level_conditional()
		_localctx =  Modl_top_level_conditionalContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 14, RULE_modl_top_level_conditional)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

      @_state_number = 146
			match(LCBRAC)
      @_state_number = 147
      modl_condition_test()
      @_state_number = 148
      match(QMARK)
      @_state_number = 149
			modl_top_level_conditional_return()
      @_state_number = 158
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==FSLASH)


        @_state_number = 150
				match(FSLASH)
        @_state_number = 152
				@_err_handler.sync(self)
				_la = @_input.la(1)
				if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << NULL) | (1 << TRUE) | (1 << FALSE) | (1 << EQUALS) | (1 << LBRAC) | (1 << LSBRAC) | (1 << NUMBER) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC) | (1 << GTHAN) | (1 << LTHAN) | (1 << EXCLAM))) != 0))

          @_state_number = 151
					modl_condition_test()
				end

        @_state_number = 154
        match(QMARK)
        @_state_number = 155
				modl_top_level_conditional_return()
        @_state_number = 160
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
      @_state_number = 161
			match(RCBRAC)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_top_level_conditional_returnContext < Antlr4::Runtime::ParserRuleContext
		def modl_structure()
			return rule_contexts("Modl_structureContext")
		end
		def modl_structure_i( i)
			return rule_context("Modl_structureContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_top_level_conditional_return
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_top_level_conditional_return(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_top_level_conditional_return(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_top_level_conditional_return(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_top_level_conditional_return()
		_localctx =  Modl_top_level_conditional_returnContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 16, RULE_modl_top_level_conditional_return)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

      @_state_number = 166
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << LBRAC) | (1 << LSBRAC) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC))) != 0))


        @_state_number = 163
				modl_structure()
        @_state_number = 168
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_map_conditionalContext < Antlr4::Runtime::ParserRuleContext
		def LCBRAC()
		  return token(MODLParser::LCBRAC, 0)
		end
		def modl_condition_test()
			return rule_contexts("Modl_condition_testContext")
		end
		def modl_condition_test_i( i)
			return rule_context("Modl_condition_testContext",i)
		end
		def QMARK()
		 return tokens(MODLParser::QMARK)
		end
		def QMARK_i( i)
			return token(MODLParser::QMARK, i)
		end
		def modl_map_conditional_return()
			return rule_contexts("Modl_map_conditional_returnContext")
		end
		def modl_map_conditional_return_i( i)
			return rule_context("Modl_map_conditional_returnContext",i)
		end
		def RCBRAC()
		  return token(MODLParser::RCBRAC, 0)
		end
		def FSLASH()
		 return tokens(MODLParser::FSLASH)
		end
		def FSLASH_i( i)
			return token(MODLParser::FSLASH, i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_map_conditional
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_map_conditional(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_map_conditional(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_map_conditional(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_map_conditional()
		_localctx =  Modl_map_conditionalContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 18, RULE_modl_map_conditional)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

      @_state_number = 169
			match(LCBRAC)
      @_state_number = 170
      modl_condition_test()
      @_state_number = 171
			match(QMARK)
      @_state_number = 172
			modl_map_conditional_return()
      @_state_number = 181
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==FSLASH)


        @_state_number = 173
				match(FSLASH)
        @_state_number = 175
				@_err_handler.sync(self)
				_la = @_input.la(1)
				if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << NULL) | (1 << TRUE) | (1 << FALSE) | (1 << EQUALS) | (1 << LBRAC) | (1 << LSBRAC) | (1 << NUMBER) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC) | (1 << GTHAN) | (1 << LTHAN) | (1 << EXCLAM))) != 0))

          @_state_number = 174
					modl_condition_test()
				end

        @_state_number = 177
        match(QMARK)
        @_state_number = 178
				modl_map_conditional_return()
        @_state_number = 183
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
      @_state_number = 184
			match(RCBRAC)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_map_conditional_returnContext < Antlr4::Runtime::ParserRuleContext
		def modl_map_item()
			return rule_contexts("Modl_map_itemContext")
		end
		def modl_map_item_i( i)
			return rule_context("Modl_map_itemContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_map_conditional_return
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_map_conditional_return(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_map_conditional_return(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_map_conditional_return(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_map_conditional_return()
		_localctx =  Modl_map_conditional_returnContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 20, RULE_modl_map_conditional_return)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

      @_state_number = 187
      @_err_handler.sync(self)
			_la = @_input.la(1)
			loop do


        @_state_number = 186
				modl_map_item()
        @_state_number = 189
        @_err_handler.sync(self)
				_la = @_input.la(1)
        break if (!((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << STRING) | (1 << QUOTED) | (1 << LCBRAC))) != 0)))
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_map_itemContext < Antlr4::Runtime::ParserRuleContext
		def modl_pair()
			return rule_context("Modl_pairContext",0)
		end
		def modl_map_conditional()
			return rule_context("Modl_map_conditionalContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_map_item
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_map_item(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_map_item(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_map_item(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_map_item()
		_localctx =  Modl_map_itemContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 22, RULE_modl_map_item)
		begin
      @_state_number = 193
			@_err_handler.sync(self)
			case (@_input.la(1))
			when MODLParser::STRING, MODLParser::QUOTED
				enter_outer_alt(_localctx, 1)

        @_state_number = 191
				modl_pair()

			when MODLParser::LCBRAC
				enter_outer_alt(_localctx, 2)

        @_state_number = 192
				modl_map_conditional()
			else
				raise Antlr4::Runtime::NoViableAltException self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_array_conditionalContext < Antlr4::Runtime::ParserRuleContext
		def LCBRAC()
		  return token(MODLParser::LCBRAC, 0)
		end
		def modl_condition_test()
			return rule_contexts("Modl_condition_testContext")
		end
		def modl_condition_test_i( i)
			return rule_context("Modl_condition_testContext",i)
		end
		def QMARK()
		 return tokens(MODLParser::QMARK)
		end
		def QMARK_i( i)
			return token(MODLParser::QMARK, i)
		end
		def modl_array_conditional_return()
			return rule_contexts("Modl_array_conditional_returnContext")
		end
		def modl_array_conditional_return_i( i)
			return rule_context("Modl_array_conditional_returnContext",i)
		end
		def RCBRAC()
		  return token(MODLParser::RCBRAC, 0)
		end
		def FSLASH()
		 return tokens(MODLParser::FSLASH)
		end
		def FSLASH_i( i)
			return token(MODLParser::FSLASH, i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_array_conditional
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_array_conditional(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_array_conditional(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_array_conditional(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_array_conditional()
		_localctx =  Modl_array_conditionalContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 24, RULE_modl_array_conditional)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

      @_state_number = 195
			match(LCBRAC)
      @_state_number = 196
			modl_condition_test()
      @_state_number = 197
			match(QMARK)
      @_state_number = 198
			modl_array_conditional_return()
      @_state_number = 207
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==FSLASH)


        @_state_number = 199
				match(FSLASH)
        @_state_number = 201
				@_err_handler.sync(self)
				_la = @_input.la(1)
				if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << NULL) | (1 << TRUE) | (1 << FALSE) | (1 << EQUALS) | (1 << LBRAC) | (1 << LSBRAC) | (1 << NUMBER) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC) | (1 << GTHAN) | (1 << LTHAN) | (1 << EXCLAM))) != 0))

          @_state_number = 200
					modl_condition_test()
				end

        @_state_number = 203
        match(QMARK)
        @_state_number = 204
				modl_array_conditional_return()
        @_state_number = 209
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
      @_state_number = 210
			match(RCBRAC)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_array_conditional_returnContext < Antlr4::Runtime::ParserRuleContext
		def modl_array_item()
			return rule_contexts("Modl_array_itemContext")
		end
		def modl_array_item_i( i)
			return rule_context("Modl_array_itemContext",i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_array_conditional_return
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_array_conditional_return(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_array_conditional_return(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_array_conditional_return(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_array_conditional_return()
		_localctx =  Modl_array_conditional_returnContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 26, RULE_modl_array_conditional_return)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

      @_state_number = 213
      @_err_handler.sync(self)
			_la = @_input.la(1)
			loop do


        @_state_number = 212
				modl_array_item()
        @_state_number = 215
        @_err_handler.sync(self)
				_la = @_input.la(1)
        break if (!((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << NULL) | (1 << TRUE) | (1 << FALSE) | (1 << LBRAC) | (1 << LSBRAC) | (1 << NUMBER) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC))) != 0)))
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_array_itemContext < Antlr4::Runtime::ParserRuleContext
		def modl_array_value_item()
			return rule_context("Modl_array_value_itemContext",0)
		end
		def modl_array_conditional()
			return rule_context("Modl_array_conditionalContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_array_item
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_array_item(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_array_item(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_array_item(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_array_item()
		_localctx =  Modl_array_itemContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 28, RULE_modl_array_item)
		begin
      @_state_number = 219
			@_err_handler.sync(self)
			case (@_input.la(1))
			when MODLParser::NULL, MODLParser::TRUE, MODLParser::FALSE, MODLParser::LBRAC, MODLParser::LSBRAC, MODLParser::NUMBER, MODLParser::STRING, MODLParser::QUOTED
				enter_outer_alt(_localctx, 1)

        @_state_number = 217
				modl_array_value_item()

			when MODLParser::LCBRAC
				enter_outer_alt(_localctx, 2)

        @_state_number = 218
				modl_array_conditional()
			else
				raise Antlr4::Runtime::NoViableAltException self
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_value_conditionalContext < Antlr4::Runtime::ParserRuleContext
		def LCBRAC()
		  return token(MODLParser::LCBRAC, 0)
		end
		def modl_condition_test()
			return rule_contexts("Modl_condition_testContext")
		end
		def modl_condition_test_i( i)
			return rule_context("Modl_condition_testContext",i)
		end
		def QMARK()
		 return tokens(MODLParser::QMARK)
		end
		def QMARK_i( i)
			return token(MODLParser::QMARK, i)
		end
		def RCBRAC()
		  return token(MODLParser::RCBRAC, 0)
		end
		def modl_value_conditional_return()
			return rule_contexts("Modl_value_conditional_returnContext")
		end
		def modl_value_conditional_return_i( i)
			return rule_context("Modl_value_conditional_returnContext",i)
		end
		def FSLASH()
		 return tokens(MODLParser::FSLASH)
		end
		def FSLASH_i( i)
			return token(MODLParser::FSLASH, i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_value_conditional
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_value_conditional(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_value_conditional(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_value_conditional(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_value_conditional()
		_localctx =  Modl_value_conditionalContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 30, RULE_modl_value_conditional)
		_la = 0
		begin
			_alt = 0
			enter_outer_alt(_localctx, 1)

      @_state_number = 221
			match(LCBRAC)
      @_state_number = 222
			modl_condition_test()
      @_state_number = 223
			match(QMARK)
      @_state_number = 239
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << NULL) | (1 << TRUE) | (1 << FALSE) | (1 << LBRAC) | (1 << LSBRAC) | (1 << NUMBER) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC))) != 0))

        @_state_number = 224
				modl_value_conditional_return()
        @_state_number = 232
				@_err_handler.sync(self);
        _alt = @_interp.adaptive_predict(@_input, 30, @_ctx)
				while ( _alt!=2 && _alt!=Antlr4::Runtime::ATN::INVALID_ALT_NUMBER )
					if ( _alt==1 )


            @_state_number = 225
						match(FSLASH)
            @_state_number = 226
						modl_condition_test()
            @_state_number = 227
            match(QMARK)
            @_state_number = 228
						modl_value_conditional_return() 
					end
          @_state_number = 234
					@_err_handler.sync(self)
          _alt = @_interp.adaptive_predict(@_input, 30, @_ctx)
				end

        @_state_number = 235
        match(FSLASH)
        @_state_number = 236
        match(QMARK)
        @_state_number = 237
				modl_value_conditional_return()
			end

      @_state_number = 241
			match(RCBRAC)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_value_conditional_returnContext < Antlr4::Runtime::ParserRuleContext
		def modl_value_item()
			return rule_contexts("Modl_value_itemContext")
		end
		def modl_value_item_i( i)
			return rule_context("Modl_value_itemContext",i)
		end
		def COLON()
		 return tokens(MODLParser::COLON)
		end
		def COLON_i( i)
			return token(MODLParser::COLON, i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_value_conditional_return
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_value_conditional_return(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_value_conditional_return(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_value_conditional_return(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_value_conditional_return()
		_localctx =  Modl_value_conditional_returnContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 32, RULE_modl_value_conditional_return)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

      @_state_number = 243
			modl_value_item()
      @_state_number = 248
			@_err_handler.sync(self)
			_la = @_input.la(1)
      while (_la == COLON)


        @_state_number = 244
        match(COLON)
        @_state_number = 245
				modl_value_item()
        @_state_number = 250
				@_err_handler.sync(self)
				_la = @_input.la(1)
      end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_condition_testContext < Antlr4::Runtime::ParserRuleContext
		def modl_condition()
			return rule_contexts("Modl_conditionContext")
		end
		def modl_condition_i( i)
			return rule_context("Modl_conditionContext",i)
		end
		def modl_condition_group()
			return rule_contexts("Modl_condition_groupContext")
		end
		def modl_condition_group_i( i)
			return rule_context("Modl_condition_groupContext",i)
		end
		def EXCLAM()
		 return tokens(MODLParser::EXCLAM)
		end
		def EXCLAM_i( i)
			return token(MODLParser::EXCLAM, i)
		end
		def AMP()
		 return tokens(MODLParser::AMP)
		end
		def AMP_i( i)
			return token(MODLParser::AMP, i)
		end
		def PIPE()
		 return tokens(MODLParser::PIPE)
		end
		def PIPE_i( i)
			return token(MODLParser::PIPE, i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_condition_test
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_condition_test(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_condition_test(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_condition_test(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_condition_test()
		_localctx =  Modl_condition_testContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 34, RULE_modl_condition_test)
		_la = 0
		begin
			_alt = 0
			enter_outer_alt(_localctx, 1)

      @_state_number = 252
			@_err_handler.sync(self)
      case (@_interp.adaptive_predict(@_input, 33, @_ctx))
      when 1

        @_state_number = 251
				match(EXCLAM)

      end
      @_state_number = 256
			@_err_handler.sync(self)
      case (@_interp.adaptive_predict(@_input, 34, @_ctx))
      when 1

        @_state_number = 254
				modl_condition()

      when 2

        @_state_number = 255
				modl_condition_group()

      end
      @_state_number = 268
			@_err_handler.sync(self);
      _alt = @_interp.adaptive_predict(@_input, 37, @_ctx)
			while ( _alt!=2 && _alt!=Antlr4::Runtime::ATN::INVALID_ALT_NUMBER )
				if ( _alt==1 )


          @_state_number = 258
					_la = @_input.la(1)
					if ( !(_la==AMP || _la==PIPE) )
					@_err_handler.recover_in_line(self)

					else
						if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
						  @matchedEOF = true
						end
						@_err_handler.report_match(self)
						consume()
					end
          @_state_number = 260
					@_err_handler.sync(self)
          case (@_interp.adaptive_predict(@_input, 35, @_ctx))
          when 1

            @_state_number = 259
						match(EXCLAM)

          end
          @_state_number = 264
					@_err_handler.sync(self)
          case (@_interp.adaptive_predict(@_input, 36, @_ctx))
          when 1

            @_state_number = 262
						modl_condition()

          when 2

            @_state_number = 263
						modl_condition_group()

          end
        end
        @_state_number = 270
				@_err_handler.sync(self)
        _alt = @_interp.adaptive_predict(@_input, 37, @_ctx)
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_operatorContext < Antlr4::Runtime::ParserRuleContext
		def EQUALS()
		  return token(MODLParser::EQUALS, 0)
		end
		def GTHAN()
		  return token(MODLParser::GTHAN, 0)
		end
		def LTHAN()
		  return token(MODLParser::LTHAN, 0)
		end
		def EXCLAM()
		  return token(MODLParser::EXCLAM, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_operator
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_operator(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_operator(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_operator(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_operator()
		_localctx =  Modl_operatorContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 36, RULE_modl_operator)
		begin
      @_state_number = 280
			@_err_handler.sync(self)
      case (@_interp.adaptive_predict(@_input, 38, @_ctx))
      when 1
				enter_outer_alt(_localctx, 1)

        @_state_number = 271
				match(EQUALS)

      when 2
				enter_outer_alt(_localctx, 2)

        @_state_number = 272
				match(GTHAN)

      when 3
				enter_outer_alt(_localctx, 3)

        @_state_number = 273
				match(GTHAN)
        @_state_number = 274
				match(EQUALS)

      when 4
				enter_outer_alt(_localctx, 4)

        @_state_number = 275
				match(LTHAN)

      when 5
				enter_outer_alt(_localctx, 5)

        @_state_number = 276
				match(LTHAN)
        @_state_number = 277
				match(EQUALS)

      when 6
				enter_outer_alt(_localctx, 6)

        @_state_number = 278
				match(EXCLAM)
        @_state_number = 279
				match(EQUALS)

      end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_conditionContext < Antlr4::Runtime::ParserRuleContext
		def modl_value()
			return rule_contexts("Modl_valueContext")
		end
		def modl_value_i( i)
			return rule_context("Modl_valueContext",i)
		end
		def STRING()
		  return token(MODLParser::STRING, 0)
		end
		def modl_operator()
			return rule_context("Modl_operatorContext",0)
		end
		def FSLASH()
		 return tokens(MODLParser::FSLASH)
		end
		def FSLASH_i( i)
			return token(MODLParser::FSLASH, i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_condition
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_condition(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_condition(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_condition(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_condition()
		_localctx =  Modl_conditionContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 38, RULE_modl_condition)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

      @_state_number = 283
			@_err_handler.sync(self)
      case (@_interp.adaptive_predict(@_input, 39, @_ctx))
      when 1

        @_state_number = 282
				match(STRING)

      end
      @_state_number = 286
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << EQUALS) | (1 << GTHAN) | (1 << LTHAN) | (1 << EXCLAM))) != 0))

        @_state_number = 285
				modl_operator()
			end

      @_state_number = 288
			modl_value()
      @_state_number = 293
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==FSLASH)


        @_state_number = 289
        match(FSLASH)
        @_state_number = 290
				modl_value()
        @_state_number = 295
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_condition_groupContext < Antlr4::Runtime::ParserRuleContext
		def LCBRAC()
		  return token(MODLParser::LCBRAC, 0)
		end
		def modl_condition_test()
			return rule_contexts("Modl_condition_testContext")
		end
		def modl_condition_test_i( i)
			return rule_context("Modl_condition_testContext",i)
		end
		def RCBRAC()
		  return token(MODLParser::RCBRAC, 0)
		end
		def AMP()
		 return tokens(MODLParser::AMP)
		end
		def AMP_i( i)
			return token(MODLParser::AMP, i)
		end
		def PIPE()
		 return tokens(MODLParser::PIPE)
		end
		def PIPE_i( i)
			return token(MODLParser::PIPE, i)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_condition_group
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_condition_group(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_condition_group(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_condition_group(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_condition_group()
		_localctx =  Modl_condition_groupContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 40, RULE_modl_condition_group)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

      @_state_number = 296
			match(LCBRAC)
      @_state_number = 297
			modl_condition_test()
      @_state_number = 302
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==AMP || _la==PIPE)


        @_state_number = 298
				_la = @_input.la(1)
				if ( !(_la==AMP || _la==PIPE) )
				@_err_handler.recover_in_line(self)

				else
					if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
					  @matchedEOF = true
					end
					@_err_handler.report_match(self)
					consume()
				end
        @_state_number = 299
				modl_condition_test()
        @_state_number = 304
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
      @_state_number = 305
			match(RCBRAC)
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_valueContext < Antlr4::Runtime::ParserRuleContext
		def modl_map()
			return rule_context("Modl_mapContext",0)
		end
		def modl_array()
			return rule_context("Modl_arrayContext",0)
		end
		def modl_nb_array()
			return rule_context("Modl_nb_arrayContext",0)
		end
		def modl_pair()
			return rule_context("Modl_pairContext",0)
		end
		def modl_primitive()
			return rule_context("Modl_primitiveContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_value
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_value(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_value(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_value(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_value()
		_localctx =  Modl_valueContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 42, RULE_modl_value)
		begin
      @_state_number = 312
			@_err_handler.sync(self)
      case (@_interp.adaptive_predict(@_input, 43, @_ctx))
      when 1
				enter_outer_alt(_localctx, 1)

        @_state_number = 307
				modl_map()

      when 2
				enter_outer_alt(_localctx, 2)

        @_state_number = 308
				modl_array()

      when 3
				enter_outer_alt(_localctx, 3)

        @_state_number = 309
				modl_nb_array()

      when 4
				enter_outer_alt(_localctx, 4)

        @_state_number = 310
				modl_pair()

      when 5
				enter_outer_alt(_localctx, 5)

        @_state_number = 311
				modl_primitive()

      end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_array_value_itemContext < Antlr4::Runtime::ParserRuleContext
		def modl_map()
			return rule_context("Modl_mapContext",0)
		end
		def modl_pair()
			return rule_context("Modl_pairContext",0)
		end
		def modl_array()
			return rule_context("Modl_arrayContext",0)
		end
		def modl_primitive()
			return rule_context("Modl_primitiveContext",0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_array_value_item
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_array_value_item(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_array_value_item(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_array_value_item(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_array_value_item()
		_localctx =  Modl_array_value_itemContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 44, RULE_modl_array_value_item)
		begin
      @_state_number = 318
			@_err_handler.sync(self)
      case (@_interp.adaptive_predict(@_input, 44, @_ctx))
      when 1
				enter_outer_alt(_localctx, 1)

        @_state_number = 314
				modl_map()

      when 2
				enter_outer_alt(_localctx, 2)

        @_state_number = 315
				modl_pair()

      when 3
				enter_outer_alt(_localctx, 3)

        @_state_number = 316
				modl_array()

      when 4
				enter_outer_alt(_localctx, 4)

        @_state_number = 317
				modl_primitive()

      end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	 class Modl_primitiveContext < Antlr4::Runtime::ParserRuleContext
		def QUOTED()
		  return token(MODLParser::QUOTED, 0)
		end
		def NUMBER()
		  return token(MODLParser::NUMBER, 0)
		end
		def STRING()
		  return token(MODLParser::STRING, 0)
		end
		def TRUE()
		  return token(MODLParser::TRUE, 0)
		end
		def FALSE()
		  return token(MODLParser::FALSE, 0)
		end
		def NULL()
		  return token(MODLParser::NULL, 0)
		end
		def initialize( parent,  invokingState)
			super(parent, invokingState)
		end
		def getRuleIndex()
		 return RULE_modl_primitive
		end
		def enter_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.enterModl_primitive(self)
			end
		end
		def exit_rule( listener)
			if ( listener.is_a? MODLParserListener )
			  listener.exitModl_primitive(self)
			end
		end

		def accept(visitor)
			if ( visitor.is_a? MODLParserVisitor )
			  return visitor.visitModl_primitive(self)
			else
			 return visitor.visit_children(self)
			end
		end
	end

	def modl_primitive()
		_localctx =  Modl_primitiveContext.new(@_ctx, @_state_number)
		enter_rule(_localctx, 46, RULE_modl_primitive)
		_la = 0
		begin
			enter_outer_alt(_localctx, 1)

      @_state_number = 320
			_la = @_input.la(1)
			if ( !((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << NULL) | (1 << TRUE) | (1 << FALSE) | (1 << NUMBER) | (1 << STRING) | (1 << QUOTED))) != 0)) )
			@_err_handler.recover_in_line(self)

			else
				if ( @_input.la(1)==Antlr4::Runtime::Token::EOF )
				  @matchedEOF = true
				end
				@_err_handler.report_match(self)
				consume()
			end
		rescue Antlr4::Runtime::RecognitionException => re
			_localctx.exception = re
			@_err_handler.report_error(self, re)
			@_err_handler.recover(self, re)
		ensure
			exit_rule()
		end
		return _localctx
	end

	@@_serializedATN = ["\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964",
                      "\3 \u0145\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4",
                      "\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t",
                      "\20\4\21\t\21\4\22\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27",
                      "\t\27\4\30\t\30\4\31\t\31\3\2\5\2\64\n\2\3\2\3\2\3\2\7\29\n\2\f\2\16",
                      "\2<\13\2\3\2\5\2?\n\2\3\2\3\2\5\2C\n\2\3\3\3\3\3\3\3\3\5\3I\n\3\3\4",
                      "\3\4\3\4\3\4\7\4O\n\4\f\4\16\4R\13\4\5\4T\n\4\3\4\3\4\3\5\3\5\3\5\5",
                      "\5[\n\5\3\5\6\5^\n\5\r\5\16\5_\3\5\3\5\5\5d\n\5\3\5\7\5g\n\5\f\5\16",
                      "\5j\13\5\7\5l\n\5\f\5\16\5o\13\5\5\5q\n\5\3\5\3\5\3\6\3\6\6\6w\n\6",
                      "\r\6\16\6x\6\6{\n\6\r\6\16\6|\3\6\7\6\u0080\n\6\f\6\16\6\u0083\13\6",
                      "\3\6\5\6\u0086\n\6\3\7\3\7\3\7\3\7\3\7\3\7\3\7\5\7\u008f\n\7\3\b\3",
                      "\b\5\b\u0093\n\b\3\t\3\t\3\t\3\t\3\t\3\t\5\t\u009b\n\t\3\t\3\t\7\t",
                      "\u009f\n\t\f\t\16\t\u00a2\13\t\3\t\3\t\3\n\7\n\u00a7\n\n\f\n\16\n\u00aa",
                      "\13\n\3\13\3\13\3\13\3\13\3\13\3\13\5\13\u00b2\n\13\3\13\3\13\7\13",
                      "\u00b6\n\13\f\13\16\13\u00b9\13\13\3\13\3\13\3\f\6\f\u00be\n\f\r\f",
                      "\16\f\u00bf\3\r\3\r\5\r\u00c4\n\r\3\16\3\16\3\16\3\16\3\16\3\16\5\16",
                      "\u00cc\n\16\3\16\3\16\7\16\u00d0\n\16\f\16\16\16\u00d3\13\16\3\16\3",
                      "\16\3\17\6\17\u00d8\n\17\r\17\16\17\u00d9\3\20\3\20\5\20\u00de\n\20",
                      "\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\7\21\u00e9\n\21\f\21",
                      "\16\21\u00ec\13\21\3\21\3\21\3\21\3\21\5\21\u00f2\n\21\3\21\3\21\3",
                      "\22\3\22\3\22\7\22\u00f9\n\22\f\22\16\22\u00fc\13\22\3\23\5\23\u00ff",
                      "\n\23\3\23\3\23\5\23\u0103\n\23\3\23\3\23\5\23\u0107\n\23\3\23\3\23",
                      "\5\23\u010b\n\23\7\23\u010d\n\23\f\23\16\23\u0110\13\23\3\24\3\24\3",
                      "\24\3\24\3\24\3\24\3\24\3\24\3\24\5\24\u011b\n\24\3\25\5\25\u011e\n",
                      "\25\3\25\5\25\u0121\n\25\3\25\3\25\3\25\7\25\u0126\n\25\f\25\16\25",
                      "\u0129\13\25\3\26\3\26\3\26\3\26\7\26\u012f\n\26\f\26\16\26\u0132\13",
                      "\26\3\26\3\26\3\27\3\27\3\27\3\27\3\27\5\27\u013b\n\27\3\30\3\30\3",
                      "\30\3\30\5\30\u0141\n\30\3\31\3\31\3\31\2\2\32\2\4\6\b\n\f\16\20\22",
                      "\24\26\30\32\34\36 \"$&(*,.\60\2\5\4\2\21\21\23\23\3\2\34\35\6\2\4",
                      "\6\17\17\21\21\23\23\2\u0165\2B\3\2\2\2\4H\3\2\2\2\6J\3\2\2\2\bW\3",
                      "\2\2\2\nz\3\2\2\2\f\u008e\3\2\2\2\16\u0092\3\2\2\2\20\u0094\3\2\2\2",
                      "\22\u00a8\3\2\2\2\24\u00ab\3\2\2\2\26\u00bd\3\2\2\2\30\u00c3\3\2\2",
                      "\2\32\u00c5\3\2\2\2\34\u00d7\3\2\2\2\36\u00dd\3\2\2\2 \u00df\3\2\2",
                      "\2\"\u00f5\3\2\2\2$\u00fe\3\2\2\2&\u011a\3\2\2\2(\u011d\3\2\2\2*\u012a",
                      "\3\2\2\2,\u013a\3\2\2\2.\u0140\3\2\2\2\60\u0142\3\2\2\2\62\64\5\4\3",
                      "\2\63\62\3\2\2\2\63\64\3\2\2\2\64C\3\2\2\2\65:\5\4\3\2\66\67\7\t\2",
                      "\2\679\5\4\3\28\66\3\2\2\29<\3\2\2\2:8\3\2\2\2:;\3\2\2\2;>\3\2\2\2",
                      "<:\3\2\2\2=?\7\t\2\2>=\3\2\2\2>?\3\2\2\2?@\3\2\2\2@A\7\2\2\3AC\3\2",
                      "\2\2B\63\3\2\2\2B\65\3\2\2\2C\3\3\2\2\2DI\5\6\4\2EI\5\b\5\2FI\5\20",
                      "\t\2GI\5\f\7\2HD\3\2\2\2HE\3\2\2\2HF\3\2\2\2HG\3\2\2\2I\5\3\2\2\2J",
                      "S\7\13\2\2KP\5\30\r\2LM\7\t\2\2MO\5\30\r\2NL\3\2\2\2OR\3\2\2\2PN\3",
                      "\2\2\2PQ\3\2\2\2QT\3\2\2\2RP\3\2\2\2SK\3\2\2\2ST\3\2\2\2TU\3\2\2\2",
                      "UV\7\f\2\2V\7\3\2\2\2Wp\7\r\2\2X[\5\36\20\2Y[\5\n\6\2ZX\3\2\2\2ZY\3",
                      "\2\2\2[m\3\2\2\2\\^\7\t\2\2]\\\3\2\2\2^_\3\2\2\2_]\3\2\2\2_`\3\2\2",
                      "\2`c\3\2\2\2ad\5\36\20\2bd\5\n\6\2ca\3\2\2\2cb\3\2\2\2dh\3\2\2\2eg",
                      "\7\t\2\2fe\3\2\2\2gj\3\2\2\2hf\3\2\2\2hi\3\2\2\2il\3\2\2\2jh\3\2\2",
                      "\2k]\3\2\2\2lo\3\2\2\2mk\3\2\2\2mn\3\2\2\2nq\3\2\2\2om\3\2\2\2pZ\3",
                      "\2\2\2pq\3\2\2\2qr\3\2\2\2rs\7\16\2\2s\t\3\2\2\2tv\5\36\20\2uw\7\7",
                      "\2\2vu\3\2\2\2wx\3\2\2\2xv\3\2\2\2xy\3\2\2\2y{\3\2\2\2zt\3\2\2\2{|",
                      "\3\2\2\2|z\3\2\2\2|}\3\2\2\2}\u0081\3\2\2\2~\u0080\5\36\20\2\177~\3",
                      "\2\2\2\u0080\u0083\3\2\2\2\u0081\177\3\2\2\2\u0081\u0082\3\2\2\2\u0082",
                      "\u0085\3\2\2\2\u0083\u0081\3\2\2\2\u0084\u0086\7\7\2\2\u0085\u0084",
                      "\3\2\2\2\u0085\u0086\3\2\2\2\u0086\13\3\2\2\2\u0087\u0088\t\2\2\2\u0088",
                      "\u0089\7\b\2\2\u0089\u008f\5\16\b\2\u008a\u008b\7\21\2\2\u008b\u008f",
                      "\5\6\4\2\u008c\u008d\7\21\2\2\u008d\u008f\5\b\5\2\u008e\u0087\3\2\2",
                      "\2\u008e\u008a\3\2\2\2\u008e\u008c\3\2\2\2\u008f\r\3\2\2\2\u0090\u0093",
                      "\5,\27\2\u0091\u0093\5 \21\2\u0092\u0090\3\2\2\2\u0092\u0091\3\2\2",
                      "\2\u0093\17\3\2\2\2\u0094\u0095\7\25\2\2\u0095\u0096\5$\23\2\u0096",
                      "\u0097\7\27\2\2\u0097\u00a0\5\22\n\2\u0098\u009a\7\30\2\2\u0099\u009b",
                      "\5$\23\2\u009a\u0099\3\2\2\2\u009a\u009b\3\2\2\2\u009b\u009c\3\2\2",
                      "\2\u009c\u009d\7\27\2\2\u009d\u009f\5\22\n\2\u009e\u0098\3\2\2\2\u009f",
                      "\u00a2\3\2\2\2\u00a0\u009e\3\2\2\2\u00a0\u00a1\3\2\2\2\u00a1\u00a3",
                      "\3\2\2\2\u00a2\u00a0\3\2\2\2\u00a3\u00a4\7 \2\2\u00a4\21\3\2\2\2\u00a5",
                      "\u00a7\5\4\3\2\u00a6\u00a5\3\2\2\2\u00a7\u00aa\3\2\2\2\u00a8\u00a6",
                      "\3\2\2\2\u00a8\u00a9\3\2\2\2\u00a9\23\3\2\2\2\u00aa\u00a8\3\2\2\2\u00ab",
                      "\u00ac\7\25\2\2\u00ac\u00ad\5$\23\2\u00ad\u00ae\7\27\2\2\u00ae\u00b7",
                      "\5\26\f\2\u00af\u00b1\7\30\2\2\u00b0\u00b2\5$\23\2\u00b1\u00b0\3\2",
                      "\2\2\u00b1\u00b2\3\2\2\2\u00b2\u00b3\3\2\2\2\u00b3\u00b4\7\27\2\2\u00b4",
                      "\u00b6\5\26\f\2\u00b5\u00af\3\2\2\2\u00b6\u00b9\3\2\2\2\u00b7\u00b5",
                      "\3\2\2\2\u00b7\u00b8\3\2\2\2\u00b8\u00ba\3\2\2\2\u00b9\u00b7\3\2\2",
                      "\2\u00ba\u00bb\7 \2\2\u00bb\25\3\2\2\2\u00bc\u00be\5\30\r\2\u00bd\u00bc",
                      "\3\2\2\2\u00be\u00bf\3\2\2\2\u00bf\u00bd\3\2\2\2\u00bf\u00c0\3\2\2",
                      "\2\u00c0\27\3\2\2\2\u00c1\u00c4\5\f\7\2\u00c2\u00c4\5\24\13\2\u00c3",
                      "\u00c1\3\2\2\2\u00c3\u00c2\3\2\2\2\u00c4\31\3\2\2\2\u00c5\u00c6\7\25",
                      "\2\2\u00c6\u00c7\5$\23\2\u00c7\u00c8\7\27\2\2\u00c8\u00d1\5\34\17\2",
                      "\u00c9\u00cb\7\30\2\2\u00ca\u00cc\5$\23\2\u00cb\u00ca\3\2\2\2\u00cb",
                      "\u00cc\3\2\2\2\u00cc\u00cd\3\2\2\2\u00cd\u00ce\7\27\2\2\u00ce\u00d0",
                      "\5\34\17\2\u00cf\u00c9\3\2\2\2\u00d0\u00d3\3\2\2\2\u00d1\u00cf\3\2",
                      "\2\2\u00d1\u00d2\3\2\2\2\u00d2\u00d4\3\2\2\2\u00d3\u00d1\3\2\2\2\u00d4",
                      "\u00d5\7 \2\2\u00d5\33\3\2\2\2\u00d6\u00d8\5\36\20\2\u00d7\u00d6\3",
                      "\2\2\2\u00d8\u00d9\3\2\2\2\u00d9\u00d7\3\2\2\2\u00d9\u00da\3\2\2\2",
                      "\u00da\35\3\2\2\2\u00db\u00de\5.\30\2\u00dc\u00de\5\32\16\2\u00dd\u00db",
                      "\3\2\2\2\u00dd\u00dc\3\2\2\2\u00de\37\3\2\2\2\u00df\u00e0\7\25\2\2",
                      "\u00e0\u00e1\5$\23\2\u00e1\u00f1\7\27\2\2\u00e2\u00ea\5\"\22\2\u00e3",
                      "\u00e4\7\30\2\2\u00e4\u00e5\5$\23\2\u00e5\u00e6\7\27\2\2\u00e6\u00e7",
                      "\5\"\22\2\u00e7\u00e9\3\2\2\2\u00e8\u00e3\3\2\2\2\u00e9\u00ec\3\2\2",
                      "\2\u00ea\u00e8\3\2\2\2\u00ea\u00eb\3\2\2\2\u00eb\u00ed\3\2\2\2\u00ec",
                      "\u00ea\3\2\2\2\u00ed\u00ee\7\30\2\2\u00ee\u00ef\7\27\2\2\u00ef\u00f0",
                      "\5\"\22\2\u00f0\u00f2\3\2\2\2\u00f1\u00e2\3\2\2\2\u00f1\u00f2\3\2\2",
                      "\2\u00f2\u00f3\3\2\2\2\u00f3\u00f4\7 \2\2\u00f4!\3\2\2\2\u00f5\u00fa",
                      "\5\16\b\2\u00f6\u00f7\7\7\2\2\u00f7\u00f9\5\16\b\2\u00f8\u00f6\3\2",
                      "\2\2\u00f9\u00fc\3\2\2\2\u00fa\u00f8\3\2\2\2\u00fa\u00fb\3\2\2\2\u00fb",
                      "#\3\2\2\2\u00fc\u00fa\3\2\2\2\u00fd\u00ff\7\36\2\2\u00fe\u00fd\3\2",
                      "\2\2\u00fe\u00ff\3\2\2\2\u00ff\u0102\3\2\2\2\u0100\u0103\5(\25\2\u0101",
                      "\u0103\5*\26\2\u0102\u0100\3\2\2\2\u0102\u0101\3\2\2\2\u0103\u010e",
                      "\3\2\2\2\u0104\u0106\t\3\2\2\u0105\u0107\7\36\2\2\u0106\u0105\3\2\2",
                      "\2\u0106\u0107\3\2\2\2\u0107\u010a\3\2\2\2\u0108\u010b\5(\25\2\u0109",
                      "\u010b\5*\26\2\u010a\u0108\3\2\2\2\u010a\u0109\3\2\2\2\u010b\u010d",
                      "\3\2\2\2\u010c\u0104\3\2\2\2\u010d\u0110\3\2\2\2\u010e\u010c\3\2\2",
                      "\2\u010e\u010f\3\2\2\2\u010f%\3\2\2\2\u0110\u010e\3\2\2\2\u0111\u011b",
                      "\7\b\2\2\u0112\u011b\7\31\2\2\u0113\u0114\7\31\2\2\u0114\u011b\7\b",
                      "\2\2\u0115\u011b\7\32\2\2\u0116\u0117\7\32\2\2\u0117\u011b\7\b\2\2",
                      "\u0118\u0119\7\36\2\2\u0119\u011b\7\b\2\2\u011a\u0111\3\2\2\2\u011a",
                      "\u0112\3\2\2\2\u011a\u0113\3\2\2\2\u011a\u0115\3\2\2\2\u011a\u0116",
                      "\3\2\2\2\u011a\u0118\3\2\2\2\u011b\'\3\2\2\2\u011c\u011e\7\21\2\2\u011d",
                      "\u011c\3\2\2\2\u011d\u011e\3\2\2\2\u011e\u0120\3\2\2\2\u011f\u0121",
                      "\5&\24\2\u0120\u011f\3\2\2\2\u0120\u0121\3\2\2\2\u0121\u0122\3\2\2",
                      "\2\u0122\u0127\5,\27\2\u0123\u0124\7\30\2\2\u0124\u0126\5,\27\2\u0125",
                      "\u0123\3\2\2\2\u0126\u0129\3\2\2\2\u0127\u0125\3\2\2\2\u0127\u0128",
                      "\3\2\2\2\u0128)\3\2\2\2\u0129\u0127\3\2\2\2\u012a\u012b\7\25\2\2\u012b",
                      "\u0130\5$\23\2\u012c\u012d\t\3\2\2\u012d\u012f\5$\23\2\u012e\u012c",
                      "\3\2\2\2\u012f\u0132\3\2\2\2\u0130\u012e\3\2\2\2\u0130\u0131\3\2\2",
                      "\2\u0131\u0133\3\2\2\2\u0132\u0130\3\2\2\2\u0133\u0134\7 \2\2\u0134",
                      "+\3\2\2\2\u0135\u013b\5\6\4\2\u0136\u013b\5\b\5\2\u0137\u013b\5\n\6",
                      "\2\u0138\u013b\5\f\7\2\u0139\u013b\5\60\31\2\u013a\u0135\3\2\2\2\u013a",
                      "\u0136\3\2\2\2\u013a\u0137\3\2\2\2\u013a\u0138\3\2\2\2\u013a\u0139",
                      "\3\2\2\2\u013b-\3\2\2\2\u013c\u0141\5\6\4\2\u013d\u0141\5\f\7\2\u013e",
                      "\u0141\5\b\5\2\u013f\u0141\5\60\31\2\u0140\u013c\3\2\2\2\u0140\u013d",
                      "\3\2\2\2\u0140\u013e\3\2\2\2\u0140\u013f\3\2\2\2\u0141/\3\2\2\2\u0142",
                      "\u0143\t\4\2\2\u0143\61\3\2\2\2/\63:>BHPSZ_chmpx|\u0081\u0085\u008e",
                      "\u0092\u009a\u00a0\u00a8\u00b1\u00b7\u00bf\u00c3\u00cb\u00d1\u00d9",
                      "\u00dd\u00ea\u00f1\u00fa\u00fe\u0102\u0106\u010a\u010e\u011a\u011d",
                      "\u0120\u0127\u0130\u013a\u0140"].join("")

	@@_ATN = Antlr4::Runtime::ATNDeserializer.new().deserialize(@@_serializedATN)

end

end
