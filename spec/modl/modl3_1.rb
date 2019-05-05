#!/usr/bin/ruby

require 'modl/interpreter'

a = <<XXXXXXXX
 *class(
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
   [p];
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
       ab=ISO 8879\:1986
       gd="A meta-%1 %2, used to create %1 %2s such as DocBook."
         :[GML;XML]
       gs=%1
     )
   )
 )
)

XXXXXXXX

puts Modl::Interpreter.interpret(a, true)
