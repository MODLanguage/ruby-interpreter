#!/usr/bin/ruby

require 'modl'

a = <<~XXXXXXXX

  a=b
  c
  d
  e

XXXXXXXX

result = MODL.parse(a)
str = JSON.pretty_generate(result)
puts str
