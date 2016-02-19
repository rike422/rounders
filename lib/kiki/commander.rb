require 'slop'

module Kiki
  class Commander
    attr_reader :arguments

    def initialize(arguments = ARGV)
      @arguments = arguments
    end

    def execute
      case
      when argv[:help]
        puts argv
        exit
      else
        puts 'TODO!!'
      end
    end

    private

    def argv
      Slop.parse(arguments) do |options|
        options.on('-h', '--help', 'Display this help message.')
      end
    end
  end
end
