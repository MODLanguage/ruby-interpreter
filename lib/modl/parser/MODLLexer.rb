# Generated from MODLLexer.g4 by ANTLR 4.7.2
require 'antlr4/runtime'

module Modl::Parser


class MODLLexer < Antlr4::Runtime::Lexer

	@_shared_context_cache = Antlr4::Runtime::PredictionContextCache.new
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
		CONDITIONAL=1
	@@channelNames = [
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	]

	@@modeNames = [
		"DEFAULT_MODE", "CONDITIONAL"
	]

	@@ruleNames  = [
      "WS", "NULL", "TRUE", "FALSE", "COLON", "EQUALS", "SC", "COMMA", "LBRAC",
      "RBRAC", "LSBRAC", "RSBRAC", "NUMBER", "INT", "EXP", "COMMENT", "INSIDE_COMMENT",
      "STRING", "UNRESERVED", "RESERVED_CHARS", "ESCAPED", "UNICODE", "HEX",
      "HASH_PREFIX", "QUOTED", "INSIDE_QUOTES", "GRAVED", "INSIDE_GRAVES",
      "LCBRAC", "CWS", "CNULL", "CTRUE", "CFALSE", "CCOLON", "CEQUALS", "CSC",
      "CLBRAC", "CRBRAC", "CLSBRAC", "CRSBRAC", "CNUMBER", "QMARK", "FSLASH",
      "GTHAN", "LTHAN", "ASTERISK", "AMP", "PIPE", "EXCLAM", "CLCBRAC", "CSTRING",
      "CUNRESERVED", "CRESERVED_CHARS", "CESCAPED", "CCOMMENT", "CQUOTED",
      "CGRAVED", "RCBRAC"
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


	@@_serializedATN = ["\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964",
                      "\2 \u01f6\b\1\b\1\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4",
                      "\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17",
                      "\4\20\t\20\4\21\t\21\4\22\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t",
                      "\26\4\27\t\27\4\30\t\30\4\31\t\31\4\32\t\32\4\33\t\33\4\34\t\34\4\35",
                      "\t\35\4\36\t\36\4\37\t\37\4 \t \4!\t!\4\"\t\"\4#\t#\4$\t$\4%\t%\4&",
                      "\t&\4\'\t\'\4(\t(\4)\t)\4*\t*\4+\t+\4,\t,\4-\t-\4.\t.\4/\t/\4\60\t",
                      "\60\4\61\t\61\4\62\t\62\4\63\t\63\4\64\t\64\4\65\t\65\4\66\t\66\4\67",
                      "\t\67\48\t8\49\t9\4:\t:\4;\t;\3\2\6\2z\n\2\r\2\16\2{\3\2\3\2\3\3\3",
                      "\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\5\3\u008b\n\3\3\4\3\4\3\4\3",
                      "\4\3\4\3\4\3\4\3\4\3\4\3\4\5\4\u0097\n\4\3\5\3\5\3\5\3\5\3\5\3\5\3",
                      "\5\3\5\3\5\3\5\3\5\3\5\5\5\u00a5\n\5\3\6\3\6\3\7\3\7\3\b\3\b\3\t\3",
                      "\t\3\n\3\n\3\13\3\13\3\f\3\f\3\r\3\r\3\16\5\16\u00b8\n\16\3\16\3\16",
                      "\3\16\6\16\u00bd\n\16\r\16\16\16\u00be\5\16\u00c1\n\16\3\16\5\16\u00c4",
                      "\n\16\3\17\3\17\3\17\7\17\u00c9\n\17\f\17\16\17\u00cc\13\17\5\17\u00ce",
                      "\n\17\3\20\3\20\5\20\u00d2\n\20\3\20\3\20\3\21\3\21\3\21\3\21\3\21",
                      "\3\21\3\21\3\22\7\22\u00de\n\22\f\22\16\22\u00e1\13\22\3\23\3\23\5",
                      "\23\u00e5\n\23\3\23\3\23\3\23\3\23\6\23\u00eb\n\23\r\23\16\23\u00ec",
                      "\3\23\5\23\u00f0\n\23\3\23\6\23\u00f3\n\23\r\23\16\23\u00f4\3\23\5",
                      "\23\u00f8\n\23\3\23\3\23\3\23\6\23\u00fd\n\23\r\23\16\23\u00fe\7\23",
                      "\u0101\n\23\f\23\16\23\u0104\13\23\3\24\3\24\3\25\3\25\3\26\3\26\3",
                      "\26\5\26\u010d\n\26\3\26\3\26\3\26\3\26\5\26\u0113\n\26\3\27\3\27\3",
                      "\27\3\27\3\27\3\27\3\30\3\30\3\31\3\31\3\31\3\32\3\32\3\32\5\32\u0123",
                      "\n\32\3\32\3\32\3\33\7\33\u0128\n\33\f\33\16\33\u012b\13\33\3\34\3",
                      "\34\3\34\3\34\3\35\7\35\u0132\n\35\f\35\16\35\u0135\13\35\3\36\3\36",
                      "\3\36\3\36\3\37\6\37\u013c\n\37\r\37\16\37\u013d\3\37\3\37\3 \3 \3",
                      " \3 \3 \3 \3 \3 \3 \3 \3 \5 \u014d\n \3 \3 \3!\3!\3!\3!\3!\3!\3!\3",
                      "!\3!\3!\5!\u015b\n!\3!\3!\3\"\3\"\3\"\3\"\3\"\3\"\3\"\3\"\3\"\3\"\3",
                      "\"\3\"\5\"\u016b\n\"\3\"\3\"\3#\3#\3#\3#\3$\3$\3$\3$\3%\3%\3%\3%\3",
                      "&\3&\3&\3&\3\'\3\'\3\'\3\'\3(\3(\3(\3(\3)\3)\3)\3)\3*\5*\u018c\n*\3",
                      "*\3*\3*\6*\u0191\n*\r*\16*\u0192\5*\u0195\n*\3*\5*\u0198\n*\3*\3*\3",
                      "+\3+\3,\3,\3-\3-\3.\3.\3/\3/\3\60\3\60\3\61\3\61\3\62\3\62\3\63\3\63",
                      "\3\63\3\63\3\63\3\64\3\64\3\64\6\64\u01b4\n\64\r\64\16\64\u01b5\3\64",
                      "\6\64\u01b9\n\64\r\64\16\64\u01ba\3\64\3\64\3\64\6\64\u01c0\n\64\r",
                      "\64\16\64\u01c1\7\64\u01c4\n\64\f\64\16\64\u01c7\13\64\3\64\3\64\3",
                      "\65\3\65\3\66\3\66\3\67\3\67\3\67\5\67\u01d2\n\67\3\67\3\67\3\67\3",
                      "\67\5\67\u01d8\n\67\38\38\38\38\38\38\38\39\39\39\59\u01e4\n9\39\3",
                      "9\39\39\3:\3:\3:\5:\u01ed\n:\3:\3:\3:\3:\3;\3;\3;\3;\2\2<\4\3\6\4\b",
                      "\5\n\6\f\7\16\b\20\t\22\n\24\13\26\f\30\r\32\16\34\17\36\2 \2\"\20",
                      "$\2&\21(\2*\2,\2.\2\60\2\62\22\64\23\66\28\24:\2<\25>\26@\2B\2D\2F",
                      "\2H\2J\2L\2N\2P\2R\2T\2V\27X\30Z\31\\\32^\33`\34b\35d\36f\2h\2j\2l",
                      "\2n\2p\37r\2t\2v \4\2\3\16\5\2\13\f\17\17\"\"\3\2\62;\3\2\63;\4\2G",
                      "Ggg\4\2--//\4\2\f\f\17\17\16\2\n\f\16\17\"\"$%*+<=??]]__bb}}\177\177",
                      "\t\2\61\61^^ddhhppttvv\5\2\62;CHch\3\2$$\3\2bb\r\2\n\f\16\17\"%((*",
                      "+\61\61<A]]__bb}\177\2\u0220\2\4\3\2\2\2\2\6\3\2\2\2\2\b\3\2\2\2\2",
                      "\n\3\2\2\2\2\f\3\2\2\2\2\16\3\2\2\2\2\20\3\2\2\2\2\22\3\2\2\2\2\24",
                      "\3\2\2\2\2\26\3\2\2\2\2\30\3\2\2\2\2\32\3\2\2\2\2\34\3\2\2\2\2\"\3",
                      "\2\2\2\2&\3\2\2\2\2\62\3\2\2\2\2\64\3\2\2\2\28\3\2\2\2\2<\3\2\2\2\3",
                      ">\3\2\2\2\3@\3\2\2\2\3B\3\2\2\2\3D\3\2\2\2\3F\3\2\2\2\3H\3\2\2\2\3",
                      "J\3\2\2\2\3L\3\2\2\2\3N\3\2\2\2\3P\3\2\2\2\3R\3\2\2\2\3T\3\2\2\2\3",
                      "V\3\2\2\2\3X\3\2\2\2\3Z\3\2\2\2\3\\\3\2\2\2\3^\3\2\2\2\3`\3\2\2\2\3",
                      "b\3\2\2\2\3d\3\2\2\2\3f\3\2\2\2\3h\3\2\2\2\3p\3\2\2\2\3r\3\2\2\2\3",
                      "t\3\2\2\2\3v\3\2\2\2\4y\3\2\2\2\6\u008a\3\2\2\2\b\u0096\3\2\2\2\n\u00a4",
                      "\3\2\2\2\f\u00a6\3\2\2\2\16\u00a8\3\2\2\2\20\u00aa\3\2\2\2\22\u00ac",
                      "\3\2\2\2\24\u00ae\3\2\2\2\26\u00b0\3\2\2\2\30\u00b2\3\2\2\2\32\u00b4",
                      "\3\2\2\2\34\u00b7\3\2\2\2\36\u00cd\3\2\2\2 \u00cf\3\2\2\2\"\u00d5\3",
                      "\2\2\2$\u00df\3\2\2\2&\u00e4\3\2\2\2(\u0105\3\2\2\2*\u0107\3\2\2\2",
                      ",\u0112\3\2\2\2.\u0114\3\2\2\2\60\u011a\3\2\2\2\62\u011c\3\2\2\2\64",
                      "\u011f\3\2\2\2\66\u0129\3\2\2\28\u012c\3\2\2\2:\u0133\3\2\2\2<\u0136",
                      "\3\2\2\2>\u013b\3\2\2\2@\u014c\3\2\2\2B\u015a\3\2\2\2D\u016a\3\2\2",
                      "\2F\u016e\3\2\2\2H\u0172\3\2\2\2J\u0176\3\2\2\2L\u017a\3\2\2\2N\u017e",
                      "\3\2\2\2P\u0182\3\2\2\2R\u0186\3\2\2\2T\u018b\3\2\2\2V\u019b\3\2\2",
                      "\2X\u019d\3\2\2\2Z\u019f\3\2\2\2\\\u01a1\3\2\2\2^\u01a3\3\2\2\2`\u01a5",
                      "\3\2\2\2b\u01a7\3\2\2\2d\u01a9\3\2\2\2f\u01ab\3\2\2\2h\u01b3\3\2\2",
                      "\2j\u01ca\3\2\2\2l\u01cc\3\2\2\2n\u01d7\3\2\2\2p\u01d9\3\2\2\2r\u01e0",
                      "\3\2\2\2t\u01e9\3\2\2\2v\u01f2\3\2\2\2xz\t\2\2\2yx\3\2\2\2z{\3\2\2",
                      "\2{y\3\2\2\2{|\3\2\2\2|}\3\2\2\2}~\b\2\2\2~\5\3\2\2\2\177\u0080\7\62",
                      "\2\2\u0080\u0081\7\62\2\2\u0081\u008b\7\62\2\2\u0082\u0083\7p\2\2\u0083",
                      "\u0084\7w\2\2\u0084\u0085\7n\2\2\u0085\u008b\7n\2\2\u0086\u0087\7P",
                      "\2\2\u0087\u0088\7W\2\2\u0088\u0089\7N\2\2\u0089\u008b\7N\2\2\u008a",
                      "\177\3\2\2\2\u008a\u0082\3\2\2\2\u008a\u0086\3\2\2\2\u008b\7\3\2\2",
                      "\2\u008c\u008d\7\62\2\2\u008d\u0097\7\63\2\2\u008e\u008f\7v\2\2\u008f",
                      "\u0090\7t\2\2\u0090\u0091\7w\2\2\u0091\u0097\7g\2\2\u0092\u0093\7V",
                      "\2\2\u0093\u0094\7T\2\2\u0094\u0095\7W\2\2\u0095\u0097\7G\2\2\u0096",
                      "\u008c\3\2\2\2\u0096\u008e\3\2\2\2\u0096\u0092\3\2\2\2\u0097\t\3\2",
                      "\2\2\u0098\u0099\7\62\2\2\u0099\u00a5\7\62\2\2\u009a\u009b\7h\2\2\u009b",
                      "\u009c\7c\2\2\u009c\u009d\7n\2\2\u009d\u009e\7u\2\2\u009e\u00a5\7g",
                      "\2\2\u009f\u00a0\7H\2\2\u00a0\u00a1\7C\2\2\u00a1\u00a2\7N\2\2\u00a2",
                      "\u00a3\7U\2\2\u00a3\u00a5\7G\2\2\u00a4\u0098\3\2\2\2\u00a4\u009a\3",
                      "\2\2\2\u00a4\u009f\3\2\2\2\u00a5\13\3\2\2\2\u00a6\u00a7\7<\2\2\u00a7",
                      "\r\3\2\2\2\u00a8\u00a9\7?\2\2\u00a9\17\3\2\2\2\u00aa\u00ab\7=\2\2\u00ab",
                      "\21\3\2\2\2\u00ac\u00ad\7.\2\2\u00ad\23\3\2\2\2\u00ae\u00af\7*\2\2",
                      "\u00af\25\3\2\2\2\u00b0\u00b1\7+\2\2\u00b1\27\3\2\2\2\u00b2\u00b3\7",
                      "]\2\2\u00b3\31\3\2\2\2\u00b4\u00b5\7_\2\2\u00b5\33\3\2\2\2\u00b6\u00b8",
                      "\7/\2\2\u00b7\u00b6\3\2\2\2\u00b7\u00b8\3\2\2\2\u00b8\u00b9\3\2\2\2",
                      "\u00b9\u00c0\5\36\17\2\u00ba\u00bc\7\60\2\2\u00bb\u00bd\t\3\2\2\u00bc",
                      "\u00bb\3\2\2\2\u00bd\u00be\3\2\2\2\u00be\u00bc\3\2\2\2\u00be\u00bf",
                      "\3\2\2\2\u00bf\u00c1\3\2\2\2\u00c0\u00ba\3\2\2\2\u00c0\u00c1\3\2\2",
                      "\2\u00c1\u00c3\3\2\2\2\u00c2\u00c4\5 \20\2\u00c3\u00c2\3\2\2\2\u00c3",
                      "\u00c4\3\2\2\2\u00c4\35\3\2\2\2\u00c5\u00ce\7\62\2\2\u00c6\u00ca\t",
                      "\4\2\2\u00c7\u00c9\t\3\2\2\u00c8\u00c7\3\2\2\2\u00c9\u00cc\3\2\2\2",
                      "\u00ca\u00c8\3\2\2\2\u00ca\u00cb\3\2\2\2\u00cb\u00ce\3\2\2\2\u00cc",
                      "\u00ca\3\2\2\2\u00cd\u00c5\3\2\2\2\u00cd\u00c6\3\2\2\2\u00ce\37\3\2",
                      "\2\2\u00cf\u00d1\t\5\2\2\u00d0\u00d2\t\6\2\2\u00d1\u00d0\3\2\2\2\u00d1",
                      "\u00d2\3\2\2\2\u00d2\u00d3\3\2\2\2\u00d3\u00d4\5\36\17\2\u00d4!\3\2",
                      "\2\2\u00d5\u00d6\7%\2\2\u00d6\u00d7\7%\2\2\u00d7\u00d8\3\2\2\2\u00d8",
                      "\u00d9\5$\22\2\u00d9\u00da\3\2\2\2\u00da\u00db\b\21\2\2\u00db#\3\2",
                      "\2\2\u00dc\u00de\n\7\2\2\u00dd\u00dc\3\2\2\2\u00de\u00e1\3\2\2\2\u00df",
                      "\u00dd\3\2\2\2\u00df\u00e0\3\2\2\2\u00e0%\3\2\2\2\u00e1\u00df\3\2\2",
                      "\2\u00e2\u00e3\7%\2\2\u00e3\u00e5\7\"\2\2\u00e4\u00e2\3\2\2\2\u00e4",
                      "\u00e5\3\2\2\2\u00e5\u00ea\3\2\2\2\u00e6\u00eb\5,\26\2\u00e7\u00eb",
                      "\5(\24\2\u00e8\u00eb\58\34\2\u00e9\u00eb\5\62\31\2\u00ea\u00e6\3\2",
                      "\2\2\u00ea\u00e7\3\2\2\2\u00ea\u00e8\3\2\2\2\u00ea\u00e9\3\2\2\2\u00eb",
                      "\u00ec\3\2\2\2\u00ec\u00ea\3\2\2\2\u00ec\u00ed\3\2\2\2\u00ed\u0102",
                      "\3\2\2\2\u00ee\u00f0\7%\2\2\u00ef\u00ee\3\2\2\2\u00ef\u00f0\3\2\2\2",
                      "\u00f0\u00f2\3\2\2\2\u00f1\u00f3\7\"\2\2\u00f2\u00f1\3\2\2\2\u00f3",
                      "\u00f4\3\2\2\2\u00f4\u00f2\3\2\2\2\u00f4\u00f5\3\2\2\2\u00f5\u00f7",
                      "\3\2\2\2\u00f6\u00f8\7%\2\2\u00f7\u00f6\3\2\2\2\u00f7\u00f8\3\2\2\2",
                      "\u00f8\u00fc\3\2\2\2\u00f9\u00fd\5,\26\2\u00fa\u00fd\5(\24\2\u00fb",
                      "\u00fd\58\34\2\u00fc\u00f9\3\2\2\2\u00fc\u00fa\3\2\2\2\u00fc\u00fb",
                      "\3\2\2\2\u00fd\u00fe\3\2\2\2\u00fe\u00fc\3\2\2\2\u00fe\u00ff\3\2\2",
                      "\2\u00ff\u0101\3\2\2\2\u0100\u00ef\3\2\2\2\u0101\u0104\3\2\2\2\u0102",
                      "\u0100\3\2\2\2\u0102\u0103\3\2\2\2\u0103\'\3\2\2\2\u0104\u0102\3\2",
                      "\2\2\u0105\u0106\n\b\2\2\u0106)\3\2\2\2\u0107\u0108\t\b\2\2\u0108+",
                      "\3\2\2\2\u0109\u010c\7^\2\2\u010a\u010d\t\t\2\2\u010b\u010d\5.\27\2",
                      "\u010c\u010a\3\2\2\2\u010c\u010b\3\2\2\2\u010d\u0113\3\2\2\2\u010e",
                      "\u010f\7^\2\2\u010f\u0113\5*\25\2\u0110\u0111\7\u0080\2\2\u0111\u0113",
                      "\5*\25\2\u0112\u0109\3\2\2\2\u0112\u010e\3\2\2\2\u0112\u0110\3\2\2",
                      "\2\u0113-\3\2\2\2\u0114\u0115\7w\2\2\u0115\u0116\5\60\30\2\u0116\u0117",
                      "\5\60\30\2\u0117\u0118\5\60\30\2\u0118\u0119\5\60\30\2\u0119/\3\2\2",
                      "\2\u011a\u011b\t\n\2\2\u011b\61\3\2\2\2\u011c\u011d\7%\2\2\u011d\u011e",
                      "\5&\23\2\u011e\63\3\2\2\2\u011f\u0122\7$\2\2\u0120\u0123\5&\23\2\u0121",
                      "\u0123\5\66\33\2\u0122\u0120\3\2\2\2\u0122\u0121\3\2\2\2\u0123\u0124",
                      "\3\2\2\2\u0124\u0125\7$\2\2\u0125\65\3\2\2\2\u0126\u0128\n\13\2\2\u0127",
                      "\u0126\3\2\2\2\u0128\u012b\3\2\2\2\u0129\u0127\3\2\2\2\u0129\u012a",
                      "\3\2\2\2\u012a\67\3\2\2\2\u012b\u0129\3\2\2\2\u012c\u012d\7b\2\2\u012d",
                      "\u012e\5:\35\2\u012e\u012f\7b\2\2\u012f9\3\2\2\2\u0130\u0132\n\f\2",
                      "\2\u0131\u0130\3\2\2\2\u0132\u0135\3\2\2\2\u0133\u0131\3\2\2\2\u0133",
                      "\u0134\3\2\2\2\u0134;\3\2\2\2\u0135\u0133\3\2\2\2\u0136\u0137\7}\2",
                      "\2\u0137\u0138\3\2\2\2\u0138\u0139\b\36\3\2\u0139=\3\2\2\2\u013a\u013c",
                      "\t\2\2\2\u013b\u013a\3\2\2\2\u013c\u013d\3\2\2\2\u013d\u013b\3\2\2",
                      "\2\u013d\u013e\3\2\2\2\u013e\u013f\3\2\2\2\u013f\u0140\b\37\2\2\u0140",
                      "?\3\2\2\2\u0141\u0142\7\62\2\2\u0142\u0143\7\62\2\2\u0143\u014d\7\62",
                      "\2\2\u0144\u0145\7p\2\2\u0145\u0146\7w\2\2\u0146\u0147\7n\2\2\u0147",
                      "\u014d\7n\2\2\u0148\u0149\7P\2\2\u0149\u014a\7W\2\2\u014a\u014b\7N",
                      "\2\2\u014b\u014d\7N\2\2\u014c\u0141\3\2\2\2\u014c\u0144\3\2\2\2\u014c",
                      "\u0148\3\2\2\2\u014d\u014e\3\2\2\2\u014e\u014f\b \4\2\u014fA\3\2\2",
                      "\2\u0150\u0151\7\62\2\2\u0151\u015b\7\63\2\2\u0152\u0153\7v\2\2\u0153",
                      "\u0154\7t\2\2\u0154\u0155\7w\2\2\u0155\u015b\7g\2\2\u0156\u0157\7V",
                      "\2\2\u0157\u0158\7T\2\2\u0158\u0159\7W\2\2\u0159\u015b\7G\2\2\u015a",
                      "\u0150\3\2\2\2\u015a\u0152\3\2\2\2\u015a\u0156\3\2\2\2\u015b\u015c",
                      "\3\2\2\2\u015c\u015d\b!\5\2\u015dC\3\2\2\2\u015e\u015f\7\62\2\2\u015f",
                      "\u016b\7\62\2\2\u0160\u0161\7h\2\2\u0161\u0162\7c\2\2\u0162\u0163\7",
                      "n\2\2\u0163\u0164\7u\2\2\u0164\u016b\7g\2\2\u0165\u0166\7H\2\2\u0166",
                      "\u0167\7C\2\2\u0167\u0168\7N\2\2\u0168\u0169\7U\2\2\u0169\u016b\7G",
                      "\2\2\u016a\u015e\3\2\2\2\u016a\u0160\3\2\2\2\u016a\u0165\3\2\2\2\u016b",
                      "\u016c\3\2\2\2\u016c\u016d\b\"\6\2\u016dE\3\2\2\2\u016e\u016f\7<\2",
                      "\2\u016f\u0170\3\2\2\2\u0170\u0171\b#\7\2\u0171G\3\2\2\2\u0172\u0173",
                      "\7?\2\2\u0173\u0174\3\2\2\2\u0174\u0175\b$\b\2\u0175I\3\2\2\2\u0176",
                      "\u0177\7=\2\2\u0177\u0178\3\2\2\2\u0178\u0179\b%\t\2\u0179K\3\2\2\2",
                      "\u017a\u017b\7*\2\2\u017b\u017c\3\2\2\2\u017c\u017d\b&\n\2\u017dM\3",
                      "\2\2\2\u017e\u017f\7+\2\2\u017f\u0180\3\2\2\2\u0180\u0181\b\'\13\2",
                      "\u0181O\3\2\2\2\u0182\u0183\7]\2\2\u0183\u0184\3\2\2\2\u0184\u0185",
                      "\b(\f\2\u0185Q\3\2\2\2\u0186\u0187\7_\2\2\u0187\u0188\3\2\2\2\u0188",
                      "\u0189\b)\r\2\u0189S\3\2\2\2\u018a\u018c\7/\2\2\u018b\u018a\3\2\2\2",
                      "\u018b\u018c\3\2\2\2\u018c\u018d\3\2\2\2\u018d\u0194\5\36\17\2\u018e",
                      "\u0190\7\60\2\2\u018f\u0191\t\3\2\2\u0190\u018f\3\2\2\2\u0191\u0192",
                      "\3\2\2\2\u0192\u0190\3\2\2\2\u0192\u0193\3\2\2\2\u0193\u0195\3\2\2",
                      "\2\u0194\u018e\3\2\2\2\u0194\u0195\3\2\2\2\u0195\u0197\3\2\2\2\u0196",
                      "\u0198\5 \20\2\u0197\u0196\3\2\2\2\u0197\u0198\3\2\2\2\u0198\u0199",
                      "\3\2\2\2\u0199\u019a\b*\16\2\u019aU\3\2\2\2\u019b\u019c\7A\2\2\u019c",
                      "W\3\2\2\2\u019d\u019e\7\61\2\2\u019eY\3\2\2\2\u019f\u01a0\7@\2\2\u01a0",
                      "[\3\2\2\2\u01a1\u01a2\7>\2\2\u01a2]\3\2\2\2\u01a3\u01a4\7,\2\2\u01a4",
                      "_\3\2\2\2\u01a5\u01a6\7(\2\2\u01a6a\3\2\2\2\u01a7\u01a8\7~\2\2\u01a8",
                      "c\3\2\2\2\u01a9\u01aa\7#\2\2\u01aae\3\2\2\2\u01ab\u01ac\7}\2\2\u01ac",
                      "\u01ad\3\2\2\2\u01ad\u01ae\b\63\3\2\u01ae\u01af\b\63\17\2\u01afg\3",
                      "\2\2\2\u01b0\u01b4\5n\67\2\u01b1\u01b4\5j\65\2\u01b2\u01b4\5t:\2\u01b3",
                      "\u01b0\3\2\2\2\u01b3\u01b1\3\2\2\2\u01b3\u01b2\3\2\2\2\u01b4\u01b5",
                      "\3\2\2\2\u01b5\u01b3\3\2\2\2\u01b5\u01b6\3\2\2\2\u01b6\u01c5\3\2\2",
                      "\2\u01b7\u01b9\7\"\2\2\u01b8\u01b7\3\2\2\2\u01b9\u01ba\3\2\2\2\u01ba",
                      "\u01b8\3\2\2\2\u01ba\u01bb\3\2\2\2\u01bb\u01bf\3\2\2\2\u01bc\u01c0",
                      "\5n\67\2\u01bd\u01c0\5j\65\2\u01be\u01c0\5t:\2\u01bf\u01bc\3\2\2\2",
                      "\u01bf\u01bd\3\2\2\2\u01bf\u01be\3\2\2\2\u01c0\u01c1\3\2\2\2\u01c1",
                      "\u01bf\3\2\2\2\u01c1\u01c2\3\2\2\2\u01c2\u01c4\3\2\2\2\u01c3\u01b8",
                      "\3\2\2\2\u01c4\u01c7\3\2\2\2\u01c5\u01c3\3\2\2\2\u01c5\u01c6\3\2\2",
                      "\2\u01c6\u01c8\3\2\2\2\u01c7\u01c5\3\2\2\2\u01c8\u01c9\b\64\20\2\u01c9",
                      "i\3\2\2\2\u01ca\u01cb\n\r\2\2\u01cbk\3\2\2\2\u01cc\u01cd\t\r\2\2\u01cd",
                      "m\3\2\2\2\u01ce\u01d1\7^\2\2\u01cf\u01d2\t\t\2\2\u01d0\u01d2\5.\27",
                      "\2\u01d1\u01cf\3\2\2\2\u01d1\u01d0\3\2\2\2\u01d2\u01d8\3\2\2\2\u01d3",
                      "\u01d4\7^\2\2\u01d4\u01d8\5l\66\2\u01d5\u01d6\7\u0080\2\2\u01d6\u01d8",
                      "\5l\66\2\u01d7\u01ce\3\2\2\2\u01d7\u01d3\3\2\2\2\u01d7\u01d5\3\2\2",
                      "\2\u01d8o\3\2\2\2\u01d9\u01da\7%\2\2\u01da\u01db\7%\2\2\u01db\u01dc",
                      "\3\2\2\2\u01dc\u01dd\5$\22\2\u01dd\u01de\3\2\2\2\u01de\u01df\b8\2\2",
                      "\u01dfq\3\2\2\2\u01e0\u01e3\7$\2\2\u01e1\u01e4\5&\23\2\u01e2\u01e4",
                      "\5\66\33\2\u01e3\u01e1\3\2\2\2\u01e3\u01e2\3\2\2\2\u01e4\u01e5\3\2",
                      "\2\2\u01e5\u01e6\7$\2\2\u01e6\u01e7\3\2\2\2\u01e7\u01e8\b9\21\2\u01e8",
                      "s\3\2\2\2\u01e9\u01ec\7b\2\2\u01ea\u01ed\5&\23\2\u01eb\u01ed\5:\35",
                      "\2\u01ec\u01ea\3\2\2\2\u01ec\u01eb\3\2\2\2\u01ed\u01ee\3\2\2\2\u01ee",
                      "\u01ef\7b\2\2\u01ef\u01f0\3\2\2\2\u01f0\u01f1\b:\22\2\u01f1u\3\2\2",
                      "\2\u01f2\u01f3\7\177\2\2\u01f3\u01f4\3\2\2\2\u01f4\u01f5\b;\23\2\u01f5",
                      "w\3\2\2\2\60\2\3{\u008a\u0096\u00a4\u00b7\u00be\u00c0\u00c3\u00ca\u00cd",
                      "\u00d1\u00df\u00e4\u00ea\u00ec\u00ef\u00f4\u00f7\u00fc\u00fe\u0102",
                      "\u010c\u0112\u0122\u0129\u0133\u013d\u014c\u015a\u016a\u018b\u0192",
                      "\u0194\u0197\u01b3\u01b5\u01ba\u01bf\u01c1\u01c5\u01d1\u01d7\u01e3",
                      "\u01ec\24\b\2\2\7\3\2\t\4\2\t\5\2\t\6\2\t\7\2\t\b\2\t\t\2\t\13\2\t",
                      "\f\2\t\r\2\t\16\2\t\17\2\t\25\2\t\21\2\t\23\2\t\24\2\6\2\2"].join("")

	@@_ATN = Antlr4::Runtime::ATNDeserializer.new().deserialize(@@_serializedATN)


	class << self
		@@_decisionToDFA = []
	end

	def initialize(input)
		super(input)

		i = 0
		while i < @@_ATN.number_of_decisions()
			@@_decisionToDFA[i] = Antlr4::Runtime::DFA.new(@@_ATN.decision_state(i), i)
			i+=1
		end

		@_interp = Antlr4::Runtime::LexerATNSimulator.new(self,@@_ATN,@@_decisionToDFA,@_sharedContextCache)
	end

	def getGrammarFileName()
	 return "MODLLexer.g4"
	end

	def rule_names()
	 return @@ruleNames
	end

	def serialized_atn()
	  return @@_serializedATN
	end

	def channel_names()
	  return @@channelNames
	end

	def mode_names()
	  return @@modeNames
	end

	def atn()
	 return @@_ATN
	end

end

end
