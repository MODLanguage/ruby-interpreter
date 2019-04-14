module Modl
  module Parser
    class MODLClass
      attr_accessor :id
      attr_accessor :name
      attr_accessor :superclass
      attr_accessor :assign
      attr_accessor :content

      def initialize
        @content = {}
      end

      # Find a keylist of the right length from the *assign array of arrays.
      def keylist_of_length(len)
        return [] if @assign.nil?

        @assign.each do |kl|
          return kl if kl.length == len
        end
        raise Antlr4::Runtime::ParseCancellationException,
              'No key list of the correct length in class ' + @id + ' - looking for one of length ' + len.to_s
      end

      def merge_content(new_value)
        @content.each do |k, v|
          new_value[k] = v.extract_hash
        end
        new_value
      end

      def name_or_id
        @name.nil? ? @id : @name
      end
    end
  end
end