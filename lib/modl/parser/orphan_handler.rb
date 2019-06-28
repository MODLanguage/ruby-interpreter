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

module MODL
  module Parser
    class OrphanHandler
      #
      # Return true if all strings start with '_'
      #
      def self.all_hidden(str_array)
        if str_array && str_array.length > 0
          str_array.each do |s|
            return false unless s.start_with?('_')
          end
        end
        true
      end

      #
      # Look for any orphan pairs at the top level and adopt them into a map
      # Its an error if there are duplicate keys or mixed types at the top.
      #
      def self.adopt(global, structures)
        #
        # Separate out any top-level pairs into a separate hash, checking for duplicates on the way.
        #
        if structures
          pairs = Hash.new

          # This will replace the existing structures array
          new_structures = []

          structures.each do |s|
            if s.pair
              # skip hidden pairs and instructions
              if s.pair.key.start_with?('*') || s.pair.key.start_with?('_') || s.pair.key == '?'
                new_structures.push(s)
                next
              end

              if pairs.has_key?(s.pair.key)
                # TODO: raise an exception
                puts 'Duplicate top level key.'
              else
                pairs[s.pair.key] = s
              end
            else
              if pairs.length > 0 && !all_hidden(pairs.keys)
                # TODO: raise an exception
                puts 'Mixed top-level types.'
              else
                new_structures.push(s)
              end
            end
          end

          if pairs.length > 0
            #
            # Create a map for the pairs and insert them into it.
            #
            new_map = MODL::Parser::Parsed::ParsedMap.new(global)
            pairs.values.each do |p|
              new_map.mapItems.push p unless p.pair.key.start_with?('_')
            end

            # Add the map to a new structure and insert it at the front of the structures list
            new_struct = MODL::Parser::Parsed::ParsedStructure.new(global)
            new_struct.map = new_map
            new_structures.unshift(new_struct)

            # Replace the existing structures with the new structures.
            return new_structures
          end
        end
        structures
      end
    end
  end
end