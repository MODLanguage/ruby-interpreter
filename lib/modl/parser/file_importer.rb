require 'singleton'
require 'modl/parser/object_cache'
require 'modl/parser/sutil'

module MODL
  module Parser

    # This class handled file loading from local or remote file systems.
    class FileImporter
      include Singleton

      CACHE_DISABLED = false

      def initialize
        @cache = ObjectCache.new
      end

      # Supply a single file name as a string or an array of file names.
      def import_files(files, global)
        file_names = []
        file_names += files if files.is_a? Array
        file_names << files if files.is_a? String

        file_names.each do |file_name|
          force = file_name.end_with?('!')
          file_name = Sutil.head(file_name) if force
          file_name << '.modl' unless file_name.end_with?('.txt', '.modl')
          file_name, new_val = RefProcessor.deref file_name, global if file_name.include?('%')
          if force
            # Don't use the cache if we're forcing a reload.
            @cache.evict(file_name)
            parsed = nil
          else
            # Do we have a cached version?
            parsed = @cache.get(file_name)
          end

          # Did we hit the cache?
          if parsed.nil? || CACHE_DISABLED
            # No.

            begin
              if file_name.start_with?('http')
                uri = URI(file_name)
                txt = Net::HTTP.get(uri)
              else
                txt = File.readlines(file_name).join
              end
            rescue
              raise InterpreterError, 'File not found: ' + file_name
            end
            global.loaded_file(file_name)

            # Parse the downloaded file ands extract the classes
            new_parse_context = GlobalParseContext.new
            new_parse_context.merge_pairs(global)
            parsed = MODL::Parser::Parser.parse txt, new_parse_context
            # Save it for next time
            @cache.put(file_name, parsed) unless CACHE_DISABLED
          else
            global.loaded_file(file_name)
          end
          # Extract the JSON content and add the classes and pairs to the existing GlobalParseContext hashes.
          parsed.extract_hash
          global.merge_classes(parsed.global)
          global.merge_pairs(parsed.global)
          global.merge_loaded_files(parsed.global)
          global.structures.concat(parsed.structures)
        end
      end
    end
  end
end
