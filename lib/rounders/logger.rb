require 'logger'

module Rounders
  module Logger
    class << self
      def get_logger(level = :info, formatter = nil, io: STDERR)
        logger = ::Logger.new(io)
        logger.progname = 'rounders'
        logger.level = level || :info
        logger.formatter = formatter if formatter
        logger
      end
    end
  end
end
