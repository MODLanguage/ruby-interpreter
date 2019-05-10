#!/usr/bin/ruby

require 'modl/interpreter'

ARGV.each {|a| puts MODL::Interpreter.interpret(a, true)}

