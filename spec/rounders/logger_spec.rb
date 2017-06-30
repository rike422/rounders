require 'spec_helper'

describe Rounders::Logger do
  let(:io) { StringIO.new }

  let(:formatter) do
    class LoggerFormatWithTime
      def call(severity, timestamp, progname, msg)
        "[#{timestamp.strftime('%Y/%m/%d %H:%M:%S')}] #{severity} -- #{progname}: #{msg}"
      end
    end
    LoggerFormatWithTime.new
  end
  describe '.get_logger' do
    it 'uses a custom log level' do
      logger = described_class.get_logger(:debug)
      expect(logger.level).to eq(Logger::DEBUG)
    end

    it 'uses the info level if the config is nil' do
      logger = described_class.get_logger(nil)
      expect(logger.level).to eq(Logger::INFO)
    end

    it 'logs messages with a custom format' do
      logger = described_class.get_logger(:debug, formatter, io: io)
      logger.fatal 'foo'
      expect(io.string).to match(/^\[.+\] FATAL -- rounders: foo$/)
    end
  end
end
