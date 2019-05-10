#!/usr/bin/ruby

require 'modl'

a = <<~XXXXXXXX

  _var=2;
  *L="https://s3-eu-west-1.amazonaws.com/modltestfiles/testing.txt!";
  print=%update_date

XXXXXXXX

result = MODL.parse(a)
str = JSON.pretty_generate(result)
puts str
