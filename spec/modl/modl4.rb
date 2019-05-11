#!/usr/bin/ruby

require 'modl'

a = <<~XXXXXXXX

*L=grammar_tests/demo_config;

m=out:2018-03-22 15\:25:Hi;
m=in:2018-03-22 15\:26:Hello, how are you?;
m=out:2018-03-22 15\:25:Hi, good thanks;
m=out:2018-03-22 15\:26:How about you?;
m=in:2018-03-22 15\:26:Yes, fine thanks. What are you up to?;
m=out:2018-03-22 15\:25:Just testing out MODL;
m=in:2018-03-22 15\:26:Cool!

XXXXXXXX

result = MODL.parse(a)
str = JSON.pretty_generate(result)
puts str
