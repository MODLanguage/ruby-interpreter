#!/usr/bin/ruby

require 'modl'

a = <<~XXXXXXXX

  *c(
   *i=m;
   *n=message;
   *S=map;
   *a=[
     [direction;date_time;message]
   ];
   method=sms
  );

  m=out:2018-03-22 15\:25:Hi;

XXXXXXXX

result = MODL.parse(a)
str = JSON.pretty_generate(result)
puts str
