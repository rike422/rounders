require 'rounders/commands/sub_commands/generate'

module Rounders
  class Commander
    class << self
      def start(argv = ARGV)
        if app?
          require 'rounders/commands/local_command'
          Commands::LocalCommand.start(argv)
        else
          require 'rounders/commands/global_command'
          Commands::GlobalCommand.start(argv)
        end
      end

      def app?
        Pathname(Rounders::CONFIG_DIR_PATH).exist?
      end
    end
  end
end
