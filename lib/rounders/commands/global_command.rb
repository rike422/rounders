module Rounders
  module Commands
    class GlobalCommand < Thor
      class_option :help, type: :boolean, aliases: '-h', desc: 'Help message.'
      package_name 'rounders'

      register(
        Rounders::Generators::AppGenerator,
        'new',
        'new <name> <path>',
        'generate new application'
      )

      register(
        Rounders::Generators::PluginGenerator,
        'plugin',
        'plugin <name>',
        'Generate new rounders plugin'
      )
    end
  end
end
