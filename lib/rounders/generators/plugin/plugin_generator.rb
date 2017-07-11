module Rounders
  module Generators
    class PluginGenerator < Base
      argument :name, type: :string
      argument :path, type: :string, required: false

      def set_destination_root
        n = "rounders-#{underscored_name}"
        p = path.nil? ? n : File.join(path, n)
        self.destination_root = p
      end

      def create_directory
        directory('lib')
        directory('spec')
      end

      def readme
        template 'README.md'
      end

      def gemfile
        template 'Gemfile'
      end

      def license
        template 'MIT-LICENSE'
      end

      def gemspec
        template 'rounders-%underscored_name%.gemspec.tt'
      end

      def gitignore
        template 'gitignore', '.gitignore'
      end

      def travis
        template 'travis.yml', '.travis.yml'
      end

      def rakefile
        template 'Rakefile'
      end
      # def lib
      #   template "lib/%namespaced_name%.rb.tt"
      #  template "lib/%namespaced_name%/version.rb.tt"
      #
    end
  end
end
