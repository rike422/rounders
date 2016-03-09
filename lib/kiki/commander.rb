require 'kiki/commands/generate'

module Kiki
  class Commander < Thor
    class_option :help, type: :boolean, aliases: '-h', desc: 'Help message.'
    package_name 'kiki'

    desc 'start', 'Start the Kiki'
    method_option aliases: '-s'
    def start
      Kiki::Rounder.new.start
    end

    desc 'generate [Type]', 'Generate new code'
    method_option aliases: '-g'
    subcommand 'generate', Kiki::Commands::Generate
  end
end
