#!/usr/bin/ruby

require 'modl'

a = <<~XXXXXXXX
  
    _print_two=false;
    (
        one=1;
        {
            print_two?
            two=2
        };
        three=3
    );
  
  _c=us;
  (
    test=1;
    {
      c=gb?
        country=UK
    }
  )
XXXXXXXX

result = MODL.parse(a)
str = JSON.pretty_generate(result)
puts str
