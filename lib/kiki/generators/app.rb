module Kiki
  module Generators
    class App
      attr_reader :name
      def initialize(name)
        @name = name
      end

      def app_path
        Pathname("./#{name}")
      end

      def generate!
        if app_path.exist?
          puts "#{name} already exists"
          exit
        end
        app_path.mkpath
        FileUtils.copy_entry(template_path, app_path)
        puts "create #{name}"
      end

      def template_path
        Pathname('../../../../templates/app').expand_path(__FILE__)
      end
    end
  end
end
