require 'rounders/commands/sub_commands/generate'

module Rounders
  class Commander
    class << self
      def start(argv = ARGV)
        if Rounders.global?
          require 'rounders/commands/global_command'
          Commands::GlobalCommand.start(argv)
        else
          require 'rounders/commands/local_command'
          Commands::LocalCommand.start(argv)
        end
      end
    end
  end
end
