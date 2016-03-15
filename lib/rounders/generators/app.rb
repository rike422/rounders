module Rounders
  module Generators
    class App
      attr_reader :name
      def initialize(name)
        @name = name
      end

      def target
        @target ||= Pathname(File.join(Dir.pwd, name))
      end

      def generate!
        if target.exist?
          puts "#{name} already exists"
          exit
        end
        target.mkpath
        FileUtils.copy_entry(template_path, target)
        puts "create #{name}"
      end

      def template_path
        Pathname('../../../../templates/app').expand_path(__FILE__)
      end
    end
  end
end
