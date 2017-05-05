module Rounders
  module Generators
    class AppGenerator < Base
      argument :name, type: :string
      argument :path, type: :string, required: false

      def set_destination_root
        p = path.nil? ? name : path
        self.destination_root = p
      end

      def create_directory
        directory('app')
        directory('config')
      end

      def test
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

      def gitignore
        template 'gitignore', '.gitignore'
      end

      def travis
        template 'travis.yml', '.travis.yml'
      end

      def rakefile
        template 'Rakefile'
      end
    end
  end
end
