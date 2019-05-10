#!/usr/bin/ruby

require 'modl'

a = <<XXXXXXXX
*l=grammar_tests/test_import_dir/nested_import1.txt;
*l=grammar_tests/test_import_dir/nested_import1.txt;
*l=grammar_tests/test_import_dir/nested_import1.txt;
files=%*load
XXXXXXXX

result = MODL.parse(a)
str = JSON.pretty_generate(result)
puts str
