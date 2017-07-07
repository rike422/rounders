# rubocop:disable Style/CyclomaticComplexity, Style/AbcSize:

module Rounders
  module Generators
    class Base < Thor::Group
      include Thor::Actions
      include Rounders::Plugins::Pluggable
      argument :name, type: :string

      protected

      def class_name
        Util.infrect(name).classify
      end

      def feature_path
        Pathname("#{Rounders::APP_PATH}/#{self.class.directory_name}")
      end

      def empty_directory_with_keep_file(destination, config = {})
        empty_directory(destination, config)
        keep_file(destination)
      end

      def keep_file(destination)
        create_file("#{destination}/.keep")
      end

      def underscored_name
        @underscored_name ||= Util.infrect(name).underscore
      end

      def namespaced_name
        @namespaced_name ||= Util.infrect(name.tr('-', '/')).classify
      end

      class << self
        def inherited(klass)
          klass.define_singleton_method(:source_root) do
            default_source_root
          end

          klass.define_singleton_method(:generator_name) do
            @generator_name ||= feature_name
          end

          klass.define_singleton_method(:default_source_root) do
            return unless base_name && generator_name
            return unless default_generator_root
            path = Pathname.new(default_generator_root).join('templates')
            path if path.exist?
          end

          klass.define_singleton_method(:base_name) do
            @base_name ||= begin
              base = name.to_s.split('::').first
              Rounders::Util.infrect(base).underscore unless base.nil?
            end
          end

          klass.define_singleton_method(:default_generator_root) do
            path = Pathname(__FILE__).dirname.join(generator_name.split('_').first).expand_path
            path if path.exist?
          end
        end
      end
    end
  end
end
