#!/usr/bin/ruby

require 'modl'

a = <<~XXXXXXXX

*class(*id=n;*name=name;*superclass=num);n=Elliott

XXXXXXXX

result = MODL.parse(a)
str = JSON.pretty_generate(result)
puts str
