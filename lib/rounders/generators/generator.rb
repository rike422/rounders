module Rounders
  module Generators
    class Generator < Thor
      include Rounders::Plugins::Pluggable
      include Thor::Actions

      attr_reader :name

      def initialize(name)
        @name = name
        super()
      end

      def generate
        self.destination_root = self.class.source_root
        opt = {
        }
        file_path = output_path.join(file_name)
        template(template_name, file_path.to_s, opt)
        puts "create #{file_path}"
      end

      private

      def class_name
        Hanami::Utils::String.new(name).classify
      end

      def template_name
        "#{self.class.name.split('::').last.downcase}.tt"
      end

      def file_name
        "#{Hanami::Utils::String.new(name.downcase).underscore}.rb"
      end

      def output_path
        Pathname("#{Rounders::APP_PATH}/#{self.class.directory_name}")
      end

      class << self
        def inherited(klass)
          klass.define_singleton_method(:source_root) do
            Pathname('../../../../templates/generators').expand_path(__FILE__).to_s.freeze
          end
        end
      end
    end
  end
end
