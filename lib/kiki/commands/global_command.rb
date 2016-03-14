module Kiki
  module Commands
    class GlobalCommand < Thor
      class_option :help, type: :boolean, aliases: '-h', desc: 'Help message.'
      package_name 'kiki'

      desc 'new [Path]', 'Generate new application'
      method_option aliases: '-n'
      def new(name)
        Kiki::Generators::App.new(name).generate!
      end
    end
  end
end
