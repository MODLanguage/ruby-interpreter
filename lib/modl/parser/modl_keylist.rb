module Modl
  module Parser
    # Extracts an index definition from a ParsedPair
    class KeylistExtractor
      def self.extract(pair, item)
        # the item must be an array of arrays
        pair.key_lists = []
        last_keylist_len = 0
        if item.is_a?(Parsed::ParsedValueItem) && item.value.is_a?(Parsed::ParsedValue) && item.value.array
          item.value.array.abstractArrayItems.each do |avi|
            key_list = []
            avi.arrayValueItem.array.abstractArrayItems.each do |key|
              key_list << key.arrayValueItem.string.string if key.arrayValueItem.string
              key_list << key.arrayValueItem.number.num if key.arrayValueItem.number
            end
            if key_list.length > last_keylist_len
              last_keylist_len = key_list.length
            else
              raise Antlr4::Runtime::ParseCancellationException, 'Error: Key lists in *assign are not in ascending order of list length.'
            end
            pair.key_lists << key_list
          end
        elsif item.is_a?(Parsed::ParsedArray)
          item.abstractArrayItems.each do |avi|
            key_list = []
            avi.arrayValueItem.array.abstractArrayItems.each do |key|
              key_list << key.arrayValueItem.string.string if key.arrayValueItem.string
              key_list << key.arrayValueItem.number.num if key.arrayValueItem.number
            end
            if key_list.length > last_keylist_len
              last_keylist_len = key_list.length
            else
              raise Antlr4::Runtime::ParseCancellationException, 'Error: Key lists in *assign are not in ascending order of list length.'
            end
            pair.key_lists << key_list
          end
        else
          raise Antlr4::Runtime::ParseCancellationException, 'Array of arrays expected for: ' + pair.key
        end
      end
    end
  end
end