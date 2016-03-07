require 'pathname'
module Kiki
  module Pluggable
    PLUGIN_BASE_DIR_PATH = 'plugins'.freeze
    class << self
      def included(klass)
        klass.extend Kiki::Pluggable::ClassMethods
        klass.load_plugins
      end
    end

    module ClassMethods
      def directory_name
        @directory_name ||= name.downcase.pluralize
      end

      def load_path
        @load_path ||= "#{PLUGIN_BASE_DIR_PATH}/#{directory_name}"
      end

      def load_plugins
        Pathname.glob(load_path).each do |plugin|
          require_relative plugin.expand_path
        end
      end
    end
  end
end
