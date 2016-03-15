require 'mustache'
module Rounders
  module Generators
    class Generator < Mustache
      include Rounders::Plugins::Pluggable
      attr_reader :name

      class << self
        def inherited(klass)
          klass.template_path      = Pathname('../../../../templates/generators').expand_path(__FILE__).to_s.freeze
          klass.template_name      = klass.name.demodulize.downcase
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
        file_path = output_path.join(file_name)
        file_path.open('w+') do |file|
          file.puts(render)
        end
        puts "create #{file_path}"
      end

      private

      def file_name
        "#{name.downcase.underscore}.rb"
      end

      def mkpath
        output_path.mkpath
      end

      def output_path
        Pathname("#{Rounders::PLUGIN_DIR_PATH}/#{self.class.directory_name}")
      end
    end
  end
end
