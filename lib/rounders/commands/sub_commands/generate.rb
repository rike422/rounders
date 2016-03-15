module Rounders
  module Commands
    module SubCommands
      class Generate < Thor
        desc 'handler <name> [<handlers>...]', 'Generate new handler'

        def handler(name, *handlers)
          Rounders::Generators::Handler.new(name: name, handlers: handlers).generate
        end
      end
    end
  end
end
