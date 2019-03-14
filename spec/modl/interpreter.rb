module Modl
  module Parser
    class Error < StandardError; end
    # Your code goes here...
  end
end

require '../../lib/modl/parser/MODLParserVisitor'
require '../../lib/modl/parser/MODLParserListener'
require '../../lib/modl/parser/MODLParserBaseListener'
require '../../lib/modl/parser/MODLParserBaseVisitor'
require '../../lib/modl/parser/MODLParser'
require '../../lib/modl/parser/MODLLexer'
require './modl_parser_test_listener'

test_strings = []
test_strings << "?=[a;b;c;d]:[1;2;3;4;5]\ntest=%1[0]"
test_strings << "*VERSION=1\n\"test\"=1"
test_strings << "*class(\n *id=g\n *name=glossary\n *superclass=map\n)\n*class(\n *id=t\n *name=title\n *superclass=str\n)\n*class(\n *id=d\n *name=GlossDiv\n *superclass=map\n)\n*class(\n *id=l\n *name=GlossList\n *superclass=map\n)\n*class(\n *id=e\n *name=GlossEntry\n *superclass=map\n *assign[\n   [i;s;gt;a;ab;gd;gs]\n ]\n)\n*class(\n *id=i\n *name=ID\n *superclass=str\n)\n*class(\n *id=s\n *name=SortAs\n *superclass=str\n)\n*class(\n *id=gt\n *name=GlossTerm\n *superclass=str\n)\n*class(\n *id=a\n *name=Acronym\n *superclass=str\n)\n*class(\n *id=ab\n *name=Abbrev\n *superclass=str\n)\n*class(\n *id=gd\n *name=GlossDef\n *superclass=map\n *assign=[\n   [p]\n   [p;sa]\n ]\n)\n*class(\n *id=p\n *name=para\n *superclass=str\n)\n*class(\n *id=sa\n *name=SeeAlso\n *superclass=arr\n)\n*class(\n *id=gs\n *name=GlossSee\n *superclass=str\n)\n\ng(\n ?=[SGML;markup;language]\n t=example glossary\n d(\n   t=S\n   l(\n     e(\n       i=%0\n       s=%0\n       gt=Standard Generalized %1.s %2.s\n       a=%0\n       ab=ISO 8879\\:1986\n       gd=A meta-%1 %2, used to create %1 %2s such as DocBook.\n         :[GML;XML]\n       gs=%1\n     )\n   )\n )\n)"
test_strings << "_test=1~:2\n\nresult={\n test=1~:2?\n     yes\n /?\n    no\n}"
test_strings << "_test=\"http://www.tesco.com\"\n\nresult={\n test=\"http://www.tesco.com\"?\n     yes\n /?\n    no\n}"
test_strings << "_root=tesco.com\n_branch=direct.\nnamespace1=`%branch`numrecord.`%root`\nnamespace2=`%branch`_`%root`.numq.net"
test_strings << "*class(\n *id=desc\n *name=description\n *superclass=str\n)\n\n*class(\n *id=val\n *name=value\n *superclass=str\n)\n\n*class(\n *id=media1\n *name=media1\n *superclass=map\n *assign=[\n   [desc;val]\n ]\n)\n\n*class(\n *id=media2\n *name=media2\n *superclass=map\n *assign=[\n   [desc;val]\n ]\n)\n*class(\n *id=list\n *name=list\n *superclass=map\n *assign[\n   [media1;media2]\n ]\n)\n\n\nlist=[tel;fb]:[yt;tw]"
test_strings << "?=[one;two]\ntest=Blah `%0.s` %1.s"
test_strings << "?=one:two\ntest=Blah `%0.r(o,huzzah)` `%1.t(w)`"
test_strings << "_co=at\n_l=de\n{\n co=at?\n   country=Austria\n   language={\n     l=fr?\n       French\n     /l=de?\n       German\n     /?\n       Other\n   }\n /?\n   country=Other\n}"
test_strings << "_C=gb\n_COUNTRIES(\n us=United States\n gb=United Kingdom\n de=Germany\n)\n\ncountry_name = %COUNTRIES[%C]"
test_strings << '?[[a;b;c];[one;two;three]];letters=%0;numbers=%1'
test_strings << "*I=\"http://config.modl.uk/demo/message-thread.txt\"\n*class(\n *id=m\n *name=message\n *superclass=map\n *assign=[\n   [direction;date_time;message]\n ]\n method=sms\n)\n\nm=out:2018-03-22 15\\:25:Hi\nm=in:2018-03-22 15\\:26:Hello, how are you?\nm=out:2018-03-22 15\\:25:Hi, good thanks\nm=out:2018-03-22 15\\:26:How about you?\nm=in:2018-03-22 15\\:26:Yes, fine thanks. What are you up to?\nm=out:2018-03-22 15\\:25:Just testing out MODL\nm=in:2018-03-22 15\\:26:Cool!"
test_strings << "*I=demo_config\n*class(\n *id=m\n *name=message\n *superclass=map\n *assign=[\n   [direction;date_time;message]\n ]\n method=sms\n)\n\nm=out:2018-03-22 15\\:25:Hi\nm=in:2018-03-22 15\\:26:Hello, how are you?\nm=out:2018-03-22 15\\:25:Hi, good thanks\nm=out:2018-03-22 15\\:26:How about you?\nm=in:2018-03-22 15\\:26:Yes, fine thanks. What are you up to?\nm=out:2018-03-22 15\\:25:Just testing out MODL\nm=in:2018-03-22 15\\:26:Cool!"
test_strings << "*I=src/test/test_import_dir/test_import.txt\n*class(\n *id=m\n *name=message\n *superclass=map\n *assign=[\n   [direction;date_time;message]\n ]\n method=sms\n)\n\nm=out:2018-03-22 15\\:25:Hi\nm=in:2018-03-22 15\\:26:Hello, how are you?\nm=out:2018-03-22 15\\:25:Hi, good thanks\nm=out:2018-03-22 15\\:26:How about you?\nm=in:2018-03-22 15\\:26:Yes, fine thanks. What are you up to?\nm=out:2018-03-22 15\\:25:Just testing out MODL\nm=in:2018-03-22 15\\:26:Cool!"

test_strings.each do |str|
  lexer = Modl::Parser::MODLLexer.new(Antlr4::Runtime::CharStreams.from_string(str, 'Test String'))
  tokens = Antlr4::Runtime::CommonTokenStream.new(lexer)

  parser = Modl::Parser::MODLParser.new(tokens)

  #listener = MODLParserTestListener.new

  visitor = Modl::Parser::MODLParserBaseVisitor.new

  tracer = Antlr4::Runtime::Parser::TraceListener.new(parser, tokens)

  parser.add_parse_listener(tracer)

  parsed = parser.modl

  visitor.visitModl(parsed)

  #parsed.enter_rule(listener)
  #parsed.exit_rule(listener)
end
