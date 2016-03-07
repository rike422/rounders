require 'mustache'
module Kiki
  module Generators
    class Generator < Mustache
      include Kiki::Pluggable
      attr_reader :name

      class << self
        def inherited(klass)
          klass.template_path = 'templates'
          klass.template_name = klass.name.demodulize.downcase
          klass.template_extension = 'mustache.rb'
        end
      end

      def initialize(name)
        @name = name
      end

      def class_name
        name.classify
      end

      def generate
        mkpath
        output_path.join(file_name).open('w+') do |file|
          file.puts(render)
        end
      end

      private

      def file_name
        "#{name.downcase.underscore}.rb"
      end

      def mkpath
        output_path.mkpath
      end

      def output_path
        Pathname("#{Kiki::Pluggable::PLUGIN_BASE_DIR_PATH}/#{self.class.directory_name}")
      end
    end
  end
end
