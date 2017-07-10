module Rounders
  module Commands
    class LocalCommand < Thor
      class_option :help, type: :boolean, aliases: '-h', desc: 'Help message.'
      class_option :version, type: :boolean, desc: 'version'
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

      desc 'version', 'Show rounders versoin'
      def version
        puts Rounders::VERSION
      end
    end
  end
end
