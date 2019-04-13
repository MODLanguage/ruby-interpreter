require 'singleton'
require 'modl/parser/object_cache'

module Modl
  module Parser

    # This class handled file loading from local or remote file systems.
    class FileImporter
      include Singleton
      # Supply a single file name as a string or an array of file names.
      def import_files(files, global)
        file_names = []
        file_names += files if files.is_a? Array
        file_names << files if files.is_a? String

        file_names.each do |file_name|
          force = file_name.end_with?('!')
          if force
            # Don't use the cache if we're forcing a reload.
            ObjectCache.instance.evict(file_name)
            file_name = file_name.slice(0, file_name.length - 1)
            parsed = nil
          else
            # Do we have a cached version?
            parsed = ObjectCache.instance.get(file_name)
          end

          # Did we hit the cache?
          unless parsed
            # No.
            file_name << '.modl' unless file_name.end_with?('.txt', '.modl')
            file_name, new_val = RefProcessor.instance.deref file_name, global if file_name.include?('%')

            begin
              uri = URI(file_name)
              txt = Net::HTTP.get(uri)
            rescue
              begin
                txt = File.readlines(file_name).join
              rescue
                raise Antlr4::Runtime::ParseCancellationException, 'File not found: ' + file_name
              end
            end

            # Parse the downloaded file ands extract the classes
            parsed = Modl::Parser::Parser.parse txt, global
            # Save it for next time
            ObjectCache.instance.put(file_name, parsed)
          end
          # Extract the JSON content and add the classes and pairs to the existing GlobalParseContext hashes.
          parsed.extract_hash
          global.classes.merge!(parsed.global.classes)
          global.pairs.merge!(parsed.global.pairs)
        end
      end
    end
  end
end
