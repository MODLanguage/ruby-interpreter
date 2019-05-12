#!/usr/bin/ruby

require 'modl'

a = <<~XXXXXXXX

_L=en;
{
 C=ca?
    o(
      n=Tesco Canada;
      s={L=fr?
        Chaque Petite Contribution
      /?
        Every Little Helps
      }
    )
}

XXXXXXXX

result = MODL.parse(a)
str = JSON.pretty_generate(result)
puts str
