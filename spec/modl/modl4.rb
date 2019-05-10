#!/usr/bin/ruby

require 'modl'

a = <<~XXXXXXXX

*LOAD="http://modules.num.uk/1.txt";
o=Tesco:Every Little Helps:[t=Customer Service:0845555555];
## o=Tesco;

XXXXXXXX

result = MODL.parse(a)
str = JSON.pretty_generate(result)
puts str
