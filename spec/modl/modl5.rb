#!/usr/bin/ruby

require 'modl'

a = <<~XXXXXXXX
*class(*id=t;*name=test;*assign=[[a;b]]);test=1:2:3

XXXXXXXX

result = MODL.parse(a)
str = JSON.pretty_generate(result)
puts str
