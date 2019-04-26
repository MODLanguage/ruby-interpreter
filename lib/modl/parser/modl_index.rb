module Modl
  module Parser
    # Extracts an index definition from a ParsedPair
    class IndexExtractor
      def self.extract(pair, global)
        item = pair.valueItem if pair.valueItem
        item = pair.array if pair.array

        # collect all values from the object
        if item.is_a? Parsed::ParsedValueItem
          if item&.value&.text
            global.index << item.value.text
          elsif item&.value&.array
            item.value.array.abstractArrayItems.each do |avi|
              global.add_to_index(avi.arrayValueItem)
            end
          elsif item&.value&.nbArray
            item.value.nbArray.arrayItems.each do |avi|
              global.add_to_index(avi.arrayValueItem)
            end
          end
        elsif item.is_a? Parsed::ParsedArray
          item.abstractArrayItems.each do |avi|
            global.add_to_index(avi.arrayValueItem)
          end
        end
      end
    end
  end
end