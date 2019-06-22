#!/usr/bin/ruby
# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright (c) 2019 NUM Technology Ltd
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


require 'modl'

def process_modl(a)
  begin
    str = MODL::Interpreter.interpret(a, true)
    puts str
    return str
  rescue MODL::InterpreterError => e
    puts e.to_s
  rescue MODL::ParserError => e
    puts e.to_s
  end

end

a = <<~XXXXXXXX

  _test=(
    first=("v1"=[one]);
    second=("v2"=two:three)
  );
   
  testing1 = "%test.first.v1.0%%test.second.v2.0%%test.second.v2.1";
  testing2 = %test.first.v1.0%%test.second.v2.0%%test.second.v2.1

XXXXXXXX

process_modl(a)