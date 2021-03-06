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

require 'modl/parser/unicode_escape_replacer'

module MODL
  module Parser
    # Escape-sequence replacements for MODL files.
    class Substitutions

      @@subs = [
          %w(~% %),
          %w(\\% %),
          %w(~\\ \\),
          %w(\\\\ \\),
          %w(~~ ~),
          %w(\\~ ~),
          %w{~( (},
          %w{\\( (},
          %w{~) )},
          %w{\\) )},
          %w(~[ [),
          %w(\\[ [),
          %w(~] ]),
          %w(\\] ]),
          %w(~{ {),
          %w(\\{ {),
          %w(~} }),
          %w(\\} }),
          %w(~; ;),
          %w(\\; ;),
          %w(~: :),
          %w(\\: :),
          %w(~` `),
          %w(\\` `),
          %w(~" "),
          %w(\\" "),
          %w(~= =),
          %w(\\= =),
          %w(~/ /),
          %w(\\/ /),
          %w(< <),
          %w(\\< <),
          %w(~> >),
          %w(\\> >),
          %w(~& &),
          %w(\\& &),
          %w(! !),
          %w(\\! !),
          %w(~| |),
          %w(\\| |),
          ['\\t', "\t"],
          ['\\n', "\n"],
          ['\\b', "\b"],
          ['\\f', "\f"],
          ['\\r', "\r"]
      ]

      # Replace all escape sequences in the supplied string and return the new value.
      def self.process(str)
        return str unless str.is_a? String

        # Remove unescaped graves and double quotes
        new_str = Sutil.unquote(str)

        new_str = UnicodeEscapeReplacer.convert_unicode_sequences new_str

        # Handle escape sequences
        @@subs.each do |s|
          loop do
            prev = new_str
            new_str = new_str.sub(s[0], s[1])
            break unless new_str && new_str != prev
          end
        end
        new_str
      end
    end
  end
end
