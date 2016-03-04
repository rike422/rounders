require 'pathname'
module Kiki
  module Pluggable
    PLUGIN_BASE_DIR_PATH = 'plugins'.freeze
    class << self
      def included(child)
        load_plugins(child)
      end

      private

      def load_plugins(child)
        Pathname.glob(load_path(child)).each do |plugin|
          require_relative plugin.expand_path
        end
      end

      def load_path(child)
        "#{PLUGIN_BASE_DIR_PATH}/#{directory_name(child)}"
      end

      def directory_name(child)
        child.name.downcase.pluralize
      end
    end
  end
end
