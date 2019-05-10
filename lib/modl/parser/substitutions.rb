# frozen_string_literal: true

module MODL
  module Parser
    # Escape-sequence replacements for MODL files.
    class Substitutions

      @@subs = [
          ['~\\', '\\'],
          ['\\\\', '\\'],
          ['~~', '~'],
          ['\\~', '~'],
          ['~(', '('],
          ['\\(', '('],
          ['~)', ')'],
          ['\\)', ')'],
          ['~[', '['],
          ['\\[', '['],
          ['~]', ']'],
          ['\\]', ']'],
          ['~{', '{'],
          ['\\{', '{'],
          ['~}', '}'],
          ['\\}', '}'],
          ['~;', ';'],
          ['\\;', ';'],
          ['~:', ':'],
          ['\\:', ':'],
          ['~`', '`'],
          ['\\`', '`'],
          ['~"', '"'],
          ['\\"', '"'],
          ['~=', '='],
          ['\\=', '='],
          ['~/', '/'],
          ['\\/', '/'],
          ['<', '<'],
          ['\\<', '<'],
          ['~>', '>'],
          ['\\>', '>'],
          ['~&', '&'],
          ['\\&', '&'],
          ['!', '!'],
          ['\\!', '!'],
          ['~|', '|'],
          ['\\|', '|'],
          ['\\t', "\t"],
          ['\\n', "\n"],
          ['\\b', "\b"],
          ['\\f', "\f"],
          ['\\r', "\r"]
      ]

      # Replace all escape sequences in the supplied string and return the new value.
      def self.process(str)
        @@subs.each do |s|
          loop do
            prev = str
            str = str.sub(s[0], s[1])
            break unless str && str != prev
          end
        end
        str
      end
    end
  end
end
