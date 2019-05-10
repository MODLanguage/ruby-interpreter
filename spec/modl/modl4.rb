#!/usr/bin/ruby

require 'modl'

a = <<~XXXXXXXX

ab=ISO 8879\:1986;

XXXXXXXX

result = MODL.parse(a)
str = JSON.pretty_generate(result)
puts str
