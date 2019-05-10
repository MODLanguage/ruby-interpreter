module MODL
  module Parser
    # This class handles the conversion of objects that refer to classes into instances of those classes.
    # It works recursively since class usage can be nested.
    class InstructionProcessor
      def self.process(global, obj)
        if obj.is_a? Hash
          nvals = {}
          obj.keys.each do |k|
            o = obj[k]
            if o.is_a? String
              nv = process_instruction(global, o)
              nvals[k] = nv unless nv.nil?
            else
              process(global, o)
            end
          end
          obj.merge!(nvals)
        elsif obj.is_a? Array
          i = 0
          while i < obj.length
            o = obj[i]
            if o.is_a? String
              nv = process_instruction(global, o)
              obj[i] = nv unless nv.nil?
            else
              process(global, o)
            end
            i += 1
          end
        end
      end

      def self.process_instruction(global, str)
        case str
        when '%*class'
          return global.class_list
        when '%*method'
          return global.method_list
        when '%*load'
          return global.file_list
        when '%*id'
          return global.id_list
        when '%*name'
          return global.name_list
        when '%*superclass'
          return global.superclass_list
        when '%*assign'
          return global.assign_list
        when '%*transform'
          return global.transform_list
        when '%*allow'
          return global.allow_list
        when '%*expect'
          return global.allow_list
        end
      end
    end
  end
end
