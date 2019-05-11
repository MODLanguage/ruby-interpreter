#!/usr/bin/ruby

require 'modl'

a = <<~XXXXXXXX

*class(*id=n;*name=name;*superclass=str);n=00;n=01;n=000;n=999;n=Elliott

XXXXXXXX

result = MODL.parse(a)
str = JSON.pretty_generate(result)
puts str
