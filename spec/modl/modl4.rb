#!/usr/bin/ruby

require 'modl'

a = <<XXXXXXXX

*class(
  *id=root;
  *name=root;
  *superclass=arr;
  *allow=[entity]
);

x=%*expect
XXXXXXXX

result = MODL.parse(a)
str = JSON.pretty_generate(result)
puts str
