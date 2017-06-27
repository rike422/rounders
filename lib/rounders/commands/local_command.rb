module Rounders
  module Commands
    class LocalCommand < Thor
      class_option :help, type: :boolean, aliases: '-h', desc: 'Help message.'
      package_name 'rounders'

      desc 'start', 'Start the Rounders'
      option aliases: '-s'
      method_option :dotenv, type: :boolean, default: false
      method_option :daemon, type: :boolean, default: false
      method_option :pid, type: :string
      def start
        rounder = Rounders::Rounder.new(options)
        rounder.start
      end

      desc 'generate [Type]', 'Generate new code'
      method_option aliases: '-g'
      subcommand 'generate', SubCommands::Generate
    end
  end
end
