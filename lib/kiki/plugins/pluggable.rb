require 'pathname'
module Kiki
  module Plugins
    module Pluggable
      class << self
        def included(klass)
          klass.extend ClassMethods
          PluginLoader.register(klass)
        end
      end

      module ClassMethods
        def directory_name
          @directory_name ||= name.demodulize.downcase.pluralize
        end

        def load_path
          @load_path ||= File.join(Kiki::PLUGIN_DIR_PATH, directory_name)
        end

        def load_plugins
          Pathname.glob("#{load_path}/*.rb").each do |plugin|
            begin
              puts "load #{plugin.expand_path}"
              require_relative plugin.expand_path
            rescue => e
              puts e
            end
          end
        end
      end
    end
  end
end
