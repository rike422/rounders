require 'rounders/generators/base'
require 'rounders/generators/app/app_generator'
require 'rounders/generators/handler/handler_generator'
require 'rounders/generators/matcher/matcher_generator'
require 'rounders/generators/receiver/receiver_generator'

module Rounders
  module Commands
    module SubCommands
      class Generate < Thor
        register(
          Rounders::Generators::HandlerGenerator,
          'handler',
          'handler <name> [<handlers>...]',
          'Generate new handler'
        )

        register(
          Rounders::Generators::MatcherGenerator,
          'matcher',
          'matcher <name>',
          'Generate new matcher'
        )

        register(
          Rounders::Generators::ReceiverGenerator,
          'receiver',
          'receiver <name>',
          'Generate new receiver'
        )
      end
    end
  end
end
