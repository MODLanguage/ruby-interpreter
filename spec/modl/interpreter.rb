module Modl
  module Parser
    class Error < StandardError;
    end
    # Your code goes here...
  end
end

require '../../lib/modl/parser/interpreter'
require 'json'

file = File.open "../../../grammar/tests/base_tests.json"
data = JSON.parse(file.read)

success = 0
failed = 0

class_test_case = {}
class_test_case['input'] = %Q{*class(
 *id=g
 *name=glossary
 *superclass=map
)
*class(
 *id=t
 *name=title
 *superclass=str
)
*class(
 *id=d
 *name=GlossDiv
 *superclass=map
)
*class(
 *id=l
 *name=GlossList
 *superclass=map
)
*class(
 *id=e
 *name=GlossEntry
 *superclass=map
 *assign[
   [i;s;gt;a;ab;gd;gs]
 ]
)
*class(
 *id=i
 *name=ID
 *superclass=str
)
*class(
 *id=s
 *name=SortAs
 *superclass=str
)
*class(
 *id=gt
 *name=GlossTerm
 *superclass=str
)
*class(
 *id=a
 *name=Acronym
 *superclass=str
)
*class(
 *id=ab
 *name=Abbrev
 *superclass=str
)
*class(
 *id=gd
 *name=GlossDef
 *superclass=map
 *assign=[
   [p]
   [p;sa]
 ]
)
*class(
 *id=p
 *name=para
 *superclass=str
)
*class(
 *id=sa
 *name=SeeAlso
 *superclass=arr
)
*class(
 *id=gs
 *name=GlossSee
 *superclass=str
)

g(
 ?=[SGML;markup;language]
 t=example glossary
 d(
   t=S
   l(
     e(
       i=%0
       s=%0
       gt=Standard Generalized %1.s %2.s
       a=%0
       ab=ISO 8879\\:1986
       gd=A meta-%1 %2, used to create %1 %2s such as DocBook.
         :[GML;XML]
       gs=%1
     )
   )
 )
)}

class_test_case['expected_output'] = %Q{{
 "glossary" : {
   "title" : "example glossary",
   "GlossDiv" : {
     "title" : "S",
     "GlossList" : {
       "GlossEntry" : {
         "ID" : "SGML",
         "SortAs" : "SGML",
         "GlossTerm" : "Standard Generalized Markup Language",
         "Acronym" : "SGML",
         "Abbrev" : "ISO 8879:1986",
         "GlossDef" : {
           "para" : "A meta-markup language, used to create markup languages such as DocBook.",
           "SeeAlso" : [ "GML", "XML" ]
         },
         "GlossSee" : "markup"
       }
     }
   }
 }
}
}

def mangle(str)
  loop do
    break unless str.sub!('": ', '":')
  end

  loop do
    break unless str.sub!('" : ', '":')
  end

  loop do
    break unless str.sub!("\n", '')
  end

  loop do
    break unless str.sub!('[ ', '[')
  end

  loop do
    break unless str.sub!(' ]', ']')
  end

  loop do
    break unless str.sub!(' }', '}')
  end

  loop do
    break unless str.sub!('] ', ']')
  end

  loop do
    break unless str.sub!('{ ', '{')
  end

  loop do
    break unless str.sub!(', ', ',')
  end
end

data.unshift class_test_case

data.each_index do |i|
  test_case = data[i]

  puts 'Test Input: ' + test_case['input']

  result = Modl::Parser::Interpreter.interpret test_case['input']

  expected = test_case['expected_output']

  mangle(expected)
  mangle(result)

  if result == expected
    puts 'Test ' + i.to_s + ' passed.'
    puts 'Expected: ' + expected
    puts 'Found   : ' + result
    success += 1
  else
    puts 'Test ' + i.to_s + ' failed.'
    puts 'Expected: ' + expected
    puts 'Found   : ' + result
    failed += 1
    break
  end
end

puts success.to_s + ' tests PASSED and ' + failed.to_s + ' tests FAILED out of a total of ' + data.length.to_s + ' tests.'