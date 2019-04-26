#!/usr/bin/ruby

require 'modl/interpreter'

ARGV.each {|a| puts Modl::Interpreter.interpret(a, true)}

