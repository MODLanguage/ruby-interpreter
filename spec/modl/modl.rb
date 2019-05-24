#!/usr/bin/ruby

require 'modl'

a = <<~XXXXXXXX

  £x=y

XXXXXXXX

begin
  str = MODL::Interpreter.interpret(a, true)
  puts str
rescue MODL::InterpreterError => e
  puts e.to_s
rescue MODL::ParserError => e
  puts e.to_s
end