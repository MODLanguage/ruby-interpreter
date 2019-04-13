require 'singleton'
require 'modl/parser/object_cache'

module Modl::Parser

  class FileImporter
    include Singleton

    def import_files files, global
      file_names = []
      file_names += files if files.is_a? Array
      file_names << files if files.is_a? String

      file_names.each do |file_name|
        force = file_name.end_with?('!')
        ObjectCache.instance.evict(file_name) if force

        parsed = ObjectCache.instance.get(file_name)

        unless parsed

          file_name = file_name.slice(0, file_name.length - 1) if force
          file_name << '.modl' unless file_name.end_with?('.txt') || file_name.end_with?('.modl')

          if file_name.include?('%')
            file_name, new_val = RefProcessor.instance.deref file_name, global
          end

          begin
            uri = URI(file_name)
            txt = Net::HTTP.get(uri)
          rescue
            begin
              txt = File.readlines(file_name).join
            rescue
              raise Antlr4::Runtime::ParseCancellationException, "File not found: " + file_name
            end
          end

          # Parse the downloaded file ands extract the classes
          parsed = Modl::Parser::Parser.parse txt, global
          ObjectCache.instance.put(file_name, parsed)
        end
        parsed.extract_json
        global.classes.merge!(parsed.global.classes)
        global.pairs.merge!(parsed.global.pairs)
      end
    end
  end
end