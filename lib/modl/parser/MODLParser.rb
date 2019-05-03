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
	SC = 7
	COMMA = 8
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
			nil, "WS", "NULL", "TRUE", "FALSE", "COLON", "EQUALS", "SC", "COMMA",
			"LBRAC", "RBRAC", "LSBRAC", "RSBRAC", "NUMBER", "COMMENT", "STRING",
			"HASH_PREFIX", "QUOTED", "GRAVED", "LCBRAC", "CWS", "QMARK", "FSLASH",
			"GTHAN", "LTHAN", "ASTERISK", "AMP", "PIPE", "EXCLAM", "CCOMMENT", "RCBRAC"
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
		def EOF()
		  return token(MODLParser::EOF, 0)
		end
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
			enter_outer_alt(_localctx, 1)

			@_state_number = 55
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << LBRAC) | (1 << LSBRAC) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC))) != 0))

				@_state_number = 48
				modl_structure()
				@_state_number = 52
				@_err_handler.sync(self)
				_la = @_input.la(1)
				while ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << LBRAC) | (1 << LSBRAC) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC))) != 0))


					@_state_number = 49
					modl_structure()
					@_state_number = 54
					@_err_handler.sync(self)
					_la = @_input.la(1)
				end
			end

			@_state_number = 57
			match(EOF)
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
			@_state_number = 63
			@_err_handler.sync(self)
			case (@_input.la(1))
			when MODLParser::LBRAC
				enter_outer_alt(_localctx, 1)

				@_state_number = 59
				modl_map()

			when MODLParser::LSBRAC
				enter_outer_alt(_localctx, 2)

				@_state_number = 60
				modl_array()

			when MODLParser::LCBRAC
				enter_outer_alt(_localctx, 3)

				@_state_number = 61
				modl_top_level_conditional()

			when MODLParser::STRING, MODLParser::QUOTED
				enter_outer_alt(_localctx, 4)

				@_state_number = 62
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
		def SC()
		 return tokens(MODLParser::SC)
		end
		def SC_i( i)
			return token(MODLParser::SC, i)
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

			@_state_number = 65
			match(LBRAC)
			@_state_number = 74
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << STRING) | (1 << QUOTED) | (1 << LCBRAC))) != 0))

				@_state_number = 66
				modl_map_item()
				@_state_number = 71
				@_err_handler.sync(self)
				_la = @_input.la(1)
				while (_la == SC)


					@_state_number = 67
					match(SC)
					@_state_number = 68
					modl_map_item()
					@_state_number = 73
					@_err_handler.sync(self)
					_la = @_input.la(1)
				end
			end

			@_state_number = 76
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

		def SC()
			return tokens(MODLParser::SC)
		end

		def SC_i(i)
			return token(MODLParser::SC, i)
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

			@_state_number = 78
			match(LSBRAC)
			@_state_number = 103
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << NULL) | (1 << TRUE) | (1 << FALSE) | (1 << LBRAC) | (1 << LSBRAC) | (1 << NUMBER) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC))) != 0))

				@_state_number = 81
				@_err_handler.sync(self)
				case (@_interp.adaptive_predict(@_input, 5, @_ctx))
				when 1

					@_state_number = 79
					modl_array_item()

				when 2

					@_state_number = 80
					modl_nb_array()

				end
				@_state_number = 100
				@_err_handler.sync(self)
				_la = @_input.la(1)
				while (_la == SC)


					@_state_number = 84
					@_err_handler.sync(self)
					_la = @_input.la(1)
					loop do


						@_state_number = 83
						match(SC)
						@_state_number = 86
						@_err_handler.sync(self)
						_la = @_input.la(1)
						break if (!(_la == SC))
					end
					@_state_number = 90
					@_err_handler.sync(self)
					case (@_interp.adaptive_predict(@_input, 7, @_ctx))
					when 1

						@_state_number = 88
						modl_array_item()

					when 2

						@_state_number = 89
						modl_nb_array()

					end
					@_state_number = 95
					@_err_handler.sync(self);
					_alt = @_interp.adaptive_predict(@_input, 8, @_ctx)
					while (_alt != 2 && _alt != Antlr4::Runtime::ATN::INVALID_ALT_NUMBER)
						if (_alt == 1)


							@_state_number = 92
							match(SC)
						end
						@_state_number = 97
						@_err_handler.sync(self)
						_alt = @_interp.adaptive_predict(@_input, 8, @_ctx)
					end
					@_state_number = 102
					@_err_handler.sync(self)
					_la = @_input.la(1)
				end
			end

			@_state_number = 105
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

			@_state_number = 113
			@_err_handler.sync(self)
			_alt = 1
			loop do
				case (_alt)
				when 1


					@_state_number = 107
					modl_array_item()
					@_state_number = 109
					@_err_handler.sync(self)
					_alt = 1
					loop do
						case (_alt)
						when 1


							@_state_number = 108
							match(COLON)

						else
							raise Antlr4::Runtime::NoViableAltException self
						end
						@_state_number = 111
						@_err_handler.sync(self)
						_alt = @_interp.adaptive_predict(@_input, 11, @_ctx)
					    break if !( _alt!=2 && _alt!=Antlr4::Runtime::ATN::INVALID_ALT_NUMBER )
					end

				else
					raise Antlr4::Runtime::NoViableAltException self
				end
				@_state_number = 115
				@_err_handler.sync(self)
				_alt = @_interp.adaptive_predict(@_input, 12, @_ctx)
			    break if !( _alt!=2 && _alt!=Antlr4::Runtime::ATN::INVALID_ALT_NUMBER )
			end
			@_state_number = 120
			@_err_handler.sync(self);
			_alt = @_interp.adaptive_predict(@_input, 13, @_ctx)
			while ( _alt!=2 && _alt!=Antlr4::Runtime::ATN::INVALID_ALT_NUMBER )
				if ( _alt==1 )


					@_state_number = 117
					modl_array_item() 
				end
				@_state_number = 122
				@_err_handler.sync(self)
				_alt = @_interp.adaptive_predict(@_input, 13, @_ctx)
			end
			@_state_number = 124
			@_err_handler.sync(self)
			case (@_interp.adaptive_predict(@_input, 14, @_ctx))
			when 1

				@_state_number = 123
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
			@_state_number = 133
			@_err_handler.sync(self)
			case (@_interp.adaptive_predict(@_input, 15, @_ctx))
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 126
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
				@_state_number = 127
				match(EQUALS)
				@_state_number = 128
				modl_value_item()

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 129
				match(STRING)
				@_state_number = 130
				modl_map()

			when 3
				enter_outer_alt(_localctx, 3)

				@_state_number = 131
				match(STRING)
				@_state_number = 132
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

			@_state_number = 137
			@_err_handler.sync(self)
			case (@_interp.adaptive_predict(@_input, 16, @_ctx))
			when 1

				@_state_number = 135
				modl_value()

			when 2

				@_state_number = 136
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

			@_state_number = 139
			match(LCBRAC)
			@_state_number = 140
			modl_condition_test()
			@_state_number = 141
			match(QMARK)
			@_state_number = 142
			modl_top_level_conditional_return()
			@_state_number = 151
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==FSLASH)


				@_state_number = 143
				match(FSLASH)
				@_state_number = 145
				@_err_handler.sync(self)
				_la = @_input.la(1)
				if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << NULL) | (1 << TRUE) | (1 << FALSE) | (1 << EQUALS) | (1 << LBRAC) | (1 << LSBRAC) | (1 << NUMBER) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC) | (1 << GTHAN) | (1 << LTHAN) | (1 << EXCLAM))) != 0))

					@_state_number = 144
					modl_condition_test()
				end

				@_state_number = 147
				match(QMARK)
				@_state_number = 148
				modl_top_level_conditional_return()
				@_state_number = 153
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 154
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

			@_state_number = 159
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << LBRAC) | (1 << LSBRAC) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC))) != 0))


				@_state_number = 156
				modl_structure()
				@_state_number = 161
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

			@_state_number = 162
			match(LCBRAC)
			@_state_number = 163
			modl_condition_test()
			@_state_number = 164
			match(QMARK)
			@_state_number = 165
			modl_map_conditional_return()
			@_state_number = 174
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==FSLASH)


				@_state_number = 166
				match(FSLASH)
				@_state_number = 168
				@_err_handler.sync(self)
				_la = @_input.la(1)
				if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << NULL) | (1 << TRUE) | (1 << FALSE) | (1 << EQUALS) | (1 << LBRAC) | (1 << LSBRAC) | (1 << NUMBER) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC) | (1 << GTHAN) | (1 << LTHAN) | (1 << EXCLAM))) != 0))

					@_state_number = 167
					modl_condition_test()
				end

				@_state_number = 170
				match(QMARK)
				@_state_number = 171
				modl_map_conditional_return()
				@_state_number = 176
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 177
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
		def SC()
		 return tokens(MODLParser::SC)
		end
		def SC_i( i)
			return token(MODLParser::SC, i)
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

			@_state_number = 182
			@_err_handler.sync(self)
			_la = @_input.la(1)
			loop do


				@_state_number = 179
				modl_map_item()
				@_state_number = 180
				match(SC)
				@_state_number = 184
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
			@_state_number = 188
			@_err_handler.sync(self)
			case (@_input.la(1))
			when MODLParser::STRING, MODLParser::QUOTED
				enter_outer_alt(_localctx, 1)

				@_state_number = 186
				modl_pair()

			when MODLParser::LCBRAC
				enter_outer_alt(_localctx, 2)

				@_state_number = 187
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

			@_state_number = 190
			match(LCBRAC)
			@_state_number = 191
			modl_condition_test()
			@_state_number = 192
			match(QMARK)
			@_state_number = 193
			modl_array_conditional_return()
			@_state_number = 202
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==FSLASH)


				@_state_number = 194
				match(FSLASH)
				@_state_number = 196
				@_err_handler.sync(self)
				_la = @_input.la(1)
				if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << NULL) | (1 << TRUE) | (1 << FALSE) | (1 << EQUALS) | (1 << LBRAC) | (1 << LSBRAC) | (1 << NUMBER) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC) | (1 << GTHAN) | (1 << LTHAN) | (1 << EXCLAM))) != 0))

					@_state_number = 195
					modl_condition_test()
				end

				@_state_number = 198
				match(QMARK)
				@_state_number = 199
				modl_array_conditional_return()
				@_state_number = 204
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 205
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
		def SC()
		 return tokens(MODLParser::SC)
		end
		def SC_i( i)
			return token(MODLParser::SC, i)
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

			@_state_number = 210
			@_err_handler.sync(self)
			_la = @_input.la(1)
			loop do


				@_state_number = 207
				modl_array_item()
				@_state_number = 208
				match(SC)
				@_state_number = 212
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
			@_state_number = 216
			@_err_handler.sync(self)
			case (@_input.la(1))
			when MODLParser::NULL, MODLParser::TRUE, MODLParser::FALSE, MODLParser::LBRAC, MODLParser::LSBRAC, MODLParser::NUMBER, MODLParser::STRING, MODLParser::QUOTED
				enter_outer_alt(_localctx, 1)

				@_state_number = 214
				modl_array_value_item()

			when MODLParser::LCBRAC
				enter_outer_alt(_localctx, 2)

				@_state_number = 215
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

			@_state_number = 218
			match(LCBRAC)
			@_state_number = 219
			modl_condition_test()
			@_state_number = 220
			match(QMARK)
			@_state_number = 236
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << NULL) | (1 << TRUE) | (1 << FALSE) | (1 << LBRAC) | (1 << LSBRAC) | (1 << NUMBER) | (1 << STRING) | (1 << QUOTED) | (1 << LCBRAC))) != 0))

				@_state_number = 221
				modl_value_conditional_return()
				@_state_number = 229
				@_err_handler.sync(self);
				_alt = @_interp.adaptive_predict(@_input, 28, @_ctx)
				while ( _alt!=2 && _alt!=Antlr4::Runtime::ATN::INVALID_ALT_NUMBER )
					if ( _alt==1 )


						@_state_number = 222
						match(FSLASH)
						@_state_number = 223
						modl_condition_test()
						@_state_number = 224
						match(QMARK)
						@_state_number = 225
						modl_value_conditional_return() 
					end
					@_state_number = 231
					@_err_handler.sync(self)
					_alt = @_interp.adaptive_predict(@_input, 28, @_ctx)
				end

				@_state_number = 232
				match(FSLASH)
				@_state_number = 233
				match(QMARK)
				@_state_number = 234
				modl_value_conditional_return()
			end

			@_state_number = 238
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

			@_state_number = 240
			modl_value_item()
			@_state_number = 245
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la == COLON)


				@_state_number = 241
				match(COLON)
				@_state_number = 242
				modl_value_item()
				@_state_number = 247
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

			@_state_number = 249
			@_err_handler.sync(self)
			case (@_interp.adaptive_predict(@_input, 31, @_ctx))
			when 1

				@_state_number = 248
				match(EXCLAM)

			end
			@_state_number = 253
			@_err_handler.sync(self)
			case (@_interp.adaptive_predict(@_input, 32, @_ctx))
			when 1

				@_state_number = 251
				modl_condition()

			when 2

				@_state_number = 252
				modl_condition_group()

			end
			@_state_number = 265
			@_err_handler.sync(self);
			_alt = @_interp.adaptive_predict(@_input, 35, @_ctx)
			while ( _alt!=2 && _alt!=Antlr4::Runtime::ATN::INVALID_ALT_NUMBER )
				if ( _alt==1 )


					@_state_number = 255
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
					@_state_number = 257
					@_err_handler.sync(self)
					case (@_interp.adaptive_predict(@_input, 33, @_ctx))
					when 1

						@_state_number = 256
						match(EXCLAM)

					end
					@_state_number = 261
					@_err_handler.sync(self)
					case (@_interp.adaptive_predict(@_input, 34, @_ctx))
					when 1

						@_state_number = 259
						modl_condition()

					when 2

						@_state_number = 260
						modl_condition_group()

					end 
				end
				@_state_number = 267
				@_err_handler.sync(self)
				_alt = @_interp.adaptive_predict(@_input, 35, @_ctx)
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
			@_state_number = 277
			@_err_handler.sync(self)
			case (@_interp.adaptive_predict(@_input, 36, @_ctx))
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 268
				match(EQUALS)

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 269
				match(GTHAN)

			when 3
				enter_outer_alt(_localctx, 3)

				@_state_number = 270
				match(GTHAN)
				@_state_number = 271
				match(EQUALS)

			when 4
				enter_outer_alt(_localctx, 4)

				@_state_number = 272
				match(LTHAN)

			when 5
				enter_outer_alt(_localctx, 5)

				@_state_number = 273
				match(LTHAN)
				@_state_number = 274
				match(EQUALS)

			when 6
				enter_outer_alt(_localctx, 6)

				@_state_number = 275
				match(EXCLAM)
				@_state_number = 276
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

			@_state_number = 280
			@_err_handler.sync(self)
			case (@_interp.adaptive_predict(@_input, 37, @_ctx))
			when 1

				@_state_number = 279
				match(STRING)

			end
			@_state_number = 283
			@_err_handler.sync(self)
			_la = @_input.la(1)
			if ((((_la) & ~0x3f) == 0 && ((1 << _la) & ((1 << EQUALS) | (1 << GTHAN) | (1 << LTHAN) | (1 << EXCLAM))) != 0))

				@_state_number = 282
				modl_operator()
			end

			@_state_number = 285
			modl_value()
			@_state_number = 290
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==FSLASH)


				@_state_number = 286
				match(FSLASH)
				@_state_number = 287
				modl_value()
				@_state_number = 292
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

			@_state_number = 293
			match(LCBRAC)
			@_state_number = 294
			modl_condition_test()
			@_state_number = 299
			@_err_handler.sync(self)
			_la = @_input.la(1)
			while (_la==AMP || _la==PIPE)


				@_state_number = 295
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
				@_state_number = 296
				modl_condition_test()
				@_state_number = 301
				@_err_handler.sync(self)
				_la = @_input.la(1)
			end
			@_state_number = 302
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
			@_state_number = 309
			@_err_handler.sync(self)
			case (@_interp.adaptive_predict(@_input, 41, @_ctx))
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 304
				modl_map()

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 305
				modl_array()

			when 3
				enter_outer_alt(_localctx, 3)

				@_state_number = 306
				modl_nb_array()

			when 4
				enter_outer_alt(_localctx, 4)

				@_state_number = 307
				modl_pair()

			when 5
				enter_outer_alt(_localctx, 5)

				@_state_number = 308
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
			@_state_number = 315
			@_err_handler.sync(self)
			case (@_interp.adaptive_predict(@_input, 42, @_ctx))
			when 1
				enter_outer_alt(_localctx, 1)

				@_state_number = 311
				modl_map()

			when 2
				enter_outer_alt(_localctx, 2)

				@_state_number = 312
				modl_pair()

			when 3
				enter_outer_alt(_localctx, 3)

				@_state_number = 313
				modl_array()

			when 4
				enter_outer_alt(_localctx, 4)

				@_state_number = 314
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

			@_state_number = 317
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
											"\3 \u0142\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4",
											"\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t",
											"\20\4\21\t\21\4\22\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27",
											"\t\27\4\30\t\30\4\31\t\31\3\2\3\2\7\2\65\n\2\f\2\16\28\13\2\5\2:\n",
											"\2\3\2\3\2\3\3\3\3\3\3\3\3\5\3B\n\3\3\4\3\4\3\4\3\4\7\4H\n\4\f\4\16",
											"\4K\13\4\5\4M\n\4\3\4\3\4\3\5\3\5\3\5\5\5T\n\5\3\5\6\5W\n\5\r\5\16",
											"\5X\3\5\3\5\5\5]\n\5\3\5\7\5`\n\5\f\5\16\5c\13\5\7\5e\n\5\f\5\16\5",
											"h\13\5\5\5j\n\5\3\5\3\5\3\6\3\6\6\6p\n\6\r\6\16\6q\6\6t\n\6\r\6\16",
											"\6u\3\6\7\6y\n\6\f\6\16\6|\13\6\3\6\5\6\177\n\6\3\7\3\7\3\7\3\7\3\7",
											"\3\7\3\7\5\7\u0088\n\7\3\b\3\b\5\b\u008c\n\b\3\t\3\t\3\t\3\t\3\t\3",
											"\t\5\t\u0094\n\t\3\t\3\t\7\t\u0098\n\t\f\t\16\t\u009b\13\t\3\t\3\t",
											"\3\n\7\n\u00a0\n\n\f\n\16\n\u00a3\13\n\3\13\3\13\3\13\3\13\3\13\3\13",
											"\5\13\u00ab\n\13\3\13\3\13\7\13\u00af\n\13\f\13\16\13\u00b2\13\13\3",
											"\13\3\13\3\f\3\f\3\f\6\f\u00b9\n\f\r\f\16\f\u00ba\3\r\3\r\5\r\u00bf",
											"\n\r\3\16\3\16\3\16\3\16\3\16\3\16\5\16\u00c7\n\16\3\16\3\16\7\16\u00cb",
											"\n\16\f\16\16\16\u00ce\13\16\3\16\3\16\3\17\3\17\3\17\6\17\u00d5\n",
											"\17\r\17\16\17\u00d6\3\20\3\20\5\20\u00db\n\20\3\21\3\21\3\21\3\21",
											"\3\21\3\21\3\21\3\21\3\21\7\21\u00e6\n\21\f\21\16\21\u00e9\13\21\3",
											"\21\3\21\3\21\3\21\5\21\u00ef\n\21\3\21\3\21\3\22\3\22\3\22\7\22\u00f6",
											"\n\22\f\22\16\22\u00f9\13\22\3\23\5\23\u00fc\n\23\3\23\3\23\5\23\u0100",
											"\n\23\3\23\3\23\5\23\u0104\n\23\3\23\3\23\5\23\u0108\n\23\7\23\u010a",
											"\n\23\f\23\16\23\u010d\13\23\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\24",
											"\3\24\5\24\u0118\n\24\3\25\5\25\u011b\n\25\3\25\5\25\u011e\n\25\3\25",
											"\3\25\3\25\7\25\u0123\n\25\f\25\16\25\u0126\13\25\3\26\3\26\3\26\3",
											"\26\7\26\u012c\n\26\f\26\16\26\u012f\13\26\3\26\3\26\3\27\3\27\3\27",
											"\3\27\3\27\5\27\u0138\n\27\3\30\3\30\3\30\3\30\5\30\u013e\n\30\3\31",
											"\3\31\3\31\2\2\32\2\4\6\b\n\f\16\20\22\24\26\30\32\34\36 \"$&(*,.\60",
											"\2\5\4\2\21\21\23\23\3\2\34\35\6\2\4\6\17\17\21\21\23\23\2\u0160\2",
											"9\3\2\2\2\4A\3\2\2\2\6C\3\2\2\2\bP\3\2\2\2\ns\3\2\2\2\f\u0087\3\2\2",
											"\2\16\u008b\3\2\2\2\20\u008d\3\2\2\2\22\u00a1\3\2\2\2\24\u00a4\3\2",
											"\2\2\26\u00b8\3\2\2\2\30\u00be\3\2\2\2\32\u00c0\3\2\2\2\34\u00d4\3",
											"\2\2\2\36\u00da\3\2\2\2 \u00dc\3\2\2\2\"\u00f2\3\2\2\2$\u00fb\3\2\2",
											"\2&\u0117\3\2\2\2(\u011a\3\2\2\2*\u0127\3\2\2\2,\u0137\3\2\2\2.\u013d",
											"\3\2\2\2\60\u013f\3\2\2\2\62\66\5\4\3\2\63\65\5\4\3\2\64\63\3\2\2\2",
											"\658\3\2\2\2\66\64\3\2\2\2\66\67\3\2\2\2\67:\3\2\2\28\66\3\2\2\29\62",
											"\3\2\2\29:\3\2\2\2:;\3\2\2\2;<\7\2\2\3<\3\3\2\2\2=B\5\6\4\2>B\5\b\5",
											"\2?B\5\20\t\2@B\5\f\7\2A=\3\2\2\2A>\3\2\2\2A?\3\2\2\2A@\3\2\2\2B\5",
											"\3\2\2\2CL\7\13\2\2DI\5\30\r\2EF\7\t\2\2FH\5\30\r\2GE\3\2\2\2HK\3\2",
											"\2\2IG\3\2\2\2IJ\3\2\2\2JM\3\2\2\2KI\3\2\2\2LD\3\2\2\2LM\3\2\2\2MN",
											"\3\2\2\2NO\7\f\2\2O\7\3\2\2\2Pi\7\r\2\2QT\5\36\20\2RT\5\n\6\2SQ\3\2",
											"\2\2SR\3\2\2\2Tf\3\2\2\2UW\7\t\2\2VU\3\2\2\2WX\3\2\2\2XV\3\2\2\2XY",
											"\3\2\2\2Y\\\3\2\2\2Z]\5\36\20\2[]\5\n\6\2\\Z\3\2\2\2\\[\3\2\2\2]a\3",
											"\2\2\2^`\7\t\2\2_^\3\2\2\2`c\3\2\2\2a_\3\2\2\2ab\3\2\2\2be\3\2\2\2",
											"ca\3\2\2\2dV\3\2\2\2eh\3\2\2\2fd\3\2\2\2fg\3\2\2\2gj\3\2\2\2hf\3\2",
											"\2\2iS\3\2\2\2ij\3\2\2\2jk\3\2\2\2kl\7\16\2\2l\t\3\2\2\2mo\5\36\20",
											"\2np\7\7\2\2on\3\2\2\2pq\3\2\2\2qo\3\2\2\2qr\3\2\2\2rt\3\2\2\2sm\3",
											"\2\2\2tu\3\2\2\2us\3\2\2\2uv\3\2\2\2vz\3\2\2\2wy\5\36\20\2xw\3\2\2",
											"\2y|\3\2\2\2zx\3\2\2\2z{\3\2\2\2{~\3\2\2\2|z\3\2\2\2}\177\7\7\2\2~",
											"}\3\2\2\2~\177\3\2\2\2\177\13\3\2\2\2\u0080\u0081\t\2\2\2\u0081\u0082",
											"\7\b\2\2\u0082\u0088\5\16\b\2\u0083\u0084\7\21\2\2\u0084\u0088\5\6",
											"\4\2\u0085\u0086\7\21\2\2\u0086\u0088\5\b\5\2\u0087\u0080\3\2\2\2\u0087",
											"\u0083\3\2\2\2\u0087\u0085\3\2\2\2\u0088\r\3\2\2\2\u0089\u008c\5,\27",
											"\2\u008a\u008c\5 \21\2\u008b\u0089\3\2\2\2\u008b\u008a\3\2\2\2\u008c",
											"\17\3\2\2\2\u008d\u008e\7\25\2\2\u008e\u008f\5$\23\2\u008f\u0090\7",
											"\27\2\2\u0090\u0099\5\22\n\2\u0091\u0093\7\30\2\2\u0092\u0094\5$\23",
											"\2\u0093\u0092\3\2\2\2\u0093\u0094\3\2\2\2\u0094\u0095\3\2\2\2\u0095",
											"\u0096\7\27\2\2\u0096\u0098\5\22\n\2\u0097\u0091\3\2\2\2\u0098\u009b",
											"\3\2\2\2\u0099\u0097\3\2\2\2\u0099\u009a\3\2\2\2\u009a\u009c\3\2\2",
											"\2\u009b\u0099\3\2\2\2\u009c\u009d\7 \2\2\u009d\21\3\2\2\2\u009e\u00a0",
											"\5\4\3\2\u009f\u009e\3\2\2\2\u00a0\u00a3\3\2\2\2\u00a1\u009f\3\2\2",
											"\2\u00a1\u00a2\3\2\2\2\u00a2\23\3\2\2\2\u00a3\u00a1\3\2\2\2\u00a4\u00a5",
											"\7\25\2\2\u00a5\u00a6\5$\23\2\u00a6\u00a7\7\27\2\2\u00a7\u00b0\5\26",
											"\f\2\u00a8\u00aa\7\30\2\2\u00a9\u00ab\5$\23\2\u00aa\u00a9\3\2\2\2\u00aa",
											"\u00ab\3\2\2\2\u00ab\u00ac\3\2\2\2\u00ac\u00ad\7\27\2\2\u00ad\u00af",
											"\5\26\f\2\u00ae\u00a8\3\2\2\2\u00af\u00b2\3\2\2\2\u00b0\u00ae\3\2\2",
											"\2\u00b0\u00b1\3\2\2\2\u00b1\u00b3\3\2\2\2\u00b2\u00b0\3\2\2\2\u00b3",
											"\u00b4\7 \2\2\u00b4\25\3\2\2\2\u00b5\u00b6\5\30\r\2\u00b6\u00b7\7\t",
											"\2\2\u00b7\u00b9\3\2\2\2\u00b8\u00b5\3\2\2\2\u00b9\u00ba\3\2\2\2\u00ba",
											"\u00b8\3\2\2\2\u00ba\u00bb\3\2\2\2\u00bb\27\3\2\2\2\u00bc\u00bf\5\f",
											"\7\2\u00bd\u00bf\5\24\13\2\u00be\u00bc\3\2\2\2\u00be\u00bd\3\2\2\2",
											"\u00bf\31\3\2\2\2\u00c0\u00c1\7\25\2\2\u00c1\u00c2\5$\23\2\u00c2\u00c3",
											"\7\27\2\2\u00c3\u00cc\5\34\17\2\u00c4\u00c6\7\30\2\2\u00c5\u00c7\5",
											"$\23\2\u00c6\u00c5\3\2\2\2\u00c6\u00c7\3\2\2\2\u00c7\u00c8\3\2\2\2",
											"\u00c8\u00c9\7\27\2\2\u00c9\u00cb\5\34\17\2\u00ca\u00c4\3\2\2\2\u00cb",
											"\u00ce\3\2\2\2\u00cc\u00ca\3\2\2\2\u00cc\u00cd\3\2\2\2\u00cd\u00cf",
											"\3\2\2\2\u00ce\u00cc\3\2\2\2\u00cf\u00d0\7 \2\2\u00d0\33\3\2\2\2\u00d1",
											"\u00d2\5\36\20\2\u00d2\u00d3\7\t\2\2\u00d3\u00d5\3\2\2\2\u00d4\u00d1",
											"\3\2\2\2\u00d5\u00d6\3\2\2\2\u00d6\u00d4\3\2\2\2\u00d6\u00d7\3\2\2",
											"\2\u00d7\35\3\2\2\2\u00d8\u00db\5.\30\2\u00d9\u00db\5\32\16\2\u00da",
											"\u00d8\3\2\2\2\u00da\u00d9\3\2\2\2\u00db\37\3\2\2\2\u00dc\u00dd\7\25",
											"\2\2\u00dd\u00de\5$\23\2\u00de\u00ee\7\27\2\2\u00df\u00e7\5\"\22\2",
											"\u00e0\u00e1\7\30\2\2\u00e1\u00e2\5$\23\2\u00e2\u00e3\7\27\2\2\u00e3",
											"\u00e4\5\"\22\2\u00e4\u00e6\3\2\2\2\u00e5\u00e0\3\2\2\2\u00e6\u00e9",
											"\3\2\2\2\u00e7\u00e5\3\2\2\2\u00e7\u00e8\3\2\2\2\u00e8\u00ea\3\2\2",
											"\2\u00e9\u00e7\3\2\2\2\u00ea\u00eb\7\30\2\2\u00eb\u00ec\7\27\2\2\u00ec",
											"\u00ed\5\"\22\2\u00ed\u00ef\3\2\2\2\u00ee\u00df\3\2\2\2\u00ee\u00ef",
											"\3\2\2\2\u00ef\u00f0\3\2\2\2\u00f0\u00f1\7 \2\2\u00f1!\3\2\2\2\u00f2",
											"\u00f7\5\16\b\2\u00f3\u00f4\7\7\2\2\u00f4\u00f6\5\16\b\2\u00f5\u00f3",
											"\3\2\2\2\u00f6\u00f9\3\2\2\2\u00f7\u00f5\3\2\2\2\u00f7\u00f8\3\2\2",
											"\2\u00f8#\3\2\2\2\u00f9\u00f7\3\2\2\2\u00fa\u00fc\7\36\2\2\u00fb\u00fa",
											"\3\2\2\2\u00fb\u00fc\3\2\2\2\u00fc\u00ff\3\2\2\2\u00fd\u0100\5(\25",
											"\2\u00fe\u0100\5*\26\2\u00ff\u00fd\3\2\2\2\u00ff\u00fe\3\2\2\2\u0100",
											"\u010b\3\2\2\2\u0101\u0103\t\3\2\2\u0102\u0104\7\36\2\2\u0103\u0102",
											"\3\2\2\2\u0103\u0104\3\2\2\2\u0104\u0107\3\2\2\2\u0105\u0108\5(\25",
											"\2\u0106\u0108\5*\26\2\u0107\u0105\3\2\2\2\u0107\u0106\3\2\2\2\u0108",
											"\u010a\3\2\2\2\u0109\u0101\3\2\2\2\u010a\u010d\3\2\2\2\u010b\u0109",
											"\3\2\2\2\u010b\u010c\3\2\2\2\u010c%\3\2\2\2\u010d\u010b\3\2\2\2\u010e",
											"\u0118\7\b\2\2\u010f\u0118\7\31\2\2\u0110\u0111\7\31\2\2\u0111\u0118",
											"\7\b\2\2\u0112\u0118\7\32\2\2\u0113\u0114\7\32\2\2\u0114\u0118\7\b",
											"\2\2\u0115\u0116\7\36\2\2\u0116\u0118\7\b\2\2\u0117\u010e\3\2\2\2\u0117",
											"\u010f\3\2\2\2\u0117\u0110\3\2\2\2\u0117\u0112\3\2\2\2\u0117\u0113",
											"\3\2\2\2\u0117\u0115\3\2\2\2\u0118\'\3\2\2\2\u0119\u011b\7\21\2\2\u011a",
											"\u0119\3\2\2\2\u011a\u011b\3\2\2\2\u011b\u011d\3\2\2\2\u011c\u011e",
											"\5&\24\2\u011d\u011c\3\2\2\2\u011d\u011e\3\2\2\2\u011e\u011f\3\2\2",
											"\2\u011f\u0124\5,\27\2\u0120\u0121\7\30\2\2\u0121\u0123\5,\27\2\u0122",
											"\u0120\3\2\2\2\u0123\u0126\3\2\2\2\u0124\u0122\3\2\2\2\u0124\u0125",
											"\3\2\2\2\u0125)\3\2\2\2\u0126\u0124\3\2\2\2\u0127\u0128\7\25\2\2\u0128",
											"\u012d\5$\23\2\u0129\u012a\t\3\2\2\u012a\u012c\5$\23\2\u012b\u0129",
											"\3\2\2\2\u012c\u012f\3\2\2\2\u012d\u012b\3\2\2\2\u012d\u012e\3\2\2",
											"\2\u012e\u0130\3\2\2\2\u012f\u012d\3\2\2\2\u0130\u0131\7 \2\2\u0131",
											"+\3\2\2\2\u0132\u0138\5\6\4\2\u0133\u0138\5\b\5\2\u0134\u0138\5\n\6",
											"\2\u0135\u0138\5\f\7\2\u0136\u0138\5\60\31\2\u0137\u0132\3\2\2\2\u0137",
											"\u0133\3\2\2\2\u0137\u0134\3\2\2\2\u0137\u0135\3\2\2\2\u0137\u0136",
											"\3\2\2\2\u0138-\3\2\2\2\u0139\u013e\5\6\4\2\u013a\u013e\5\f\7\2\u013b",
											"\u013e\5\b\5\2\u013c\u013e\5\60\31\2\u013d\u0139\3\2\2\2\u013d\u013a",
											"\3\2\2\2\u013d\u013b\3\2\2\2\u013d\u013c\3\2\2\2\u013e/\3\2\2\2\u013f",
											"\u0140\t\4\2\2\u0140\61\3\2\2\2-\669AILSX\\afiquz~\u0087\u008b\u0093",
											"\u0099\u00a1\u00aa\u00b0\u00ba\u00be\u00c6\u00cc\u00d6\u00da\u00e7",
											"\u00ee\u00f7\u00fb\u00ff\u0103\u0107\u010b\u0117\u011a\u011d\u0124",
											"\u012d\u0137\u013d"].join("")

	@@_ATN = Antlr4::Runtime::ATNDeserializer.new().deserialize(@@_serializedATN)

end

end
