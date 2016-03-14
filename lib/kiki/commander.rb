require 'kiki/commands/sub_commands/generate'

module Kiki
  class Commander
    class << self
      def start(argv = ARGV)
        if app_path?
          require 'kiki/commands/local_command'
          Commands::LocalCommand.start(argv)
        else
          require 'kiki/commands/global_command'
          Commands::GlobalCommand.start(argv)
        end
      end

      def app_path?
        Pathname('./initializers/').exist?
      end
    end
  end
end
