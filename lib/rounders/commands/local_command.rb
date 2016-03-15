module Rounders
  module Commands
    class LocalCommand < Thor
      class_option :help, type: :boolean, aliases: '-h', desc: 'Help message.'
      package_name 'rounders'

      desc 'start', 'Start the Rounders'
      method_option aliases: '-s'
      option :dotenv
      def start
        rounder = Rounders::Rounder.new
        rounder.dotenv if options[:dotenv]
        rounder.start
      end

      desc 'generate [Type]', 'Generate new code'
      method_option aliases: '-g'
      subcommand 'generate', SubCommands::Generate
    end
  end
end
