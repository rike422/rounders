module Kiki
  class Receiver
    class Config
      attr_accessor :protocol
      attr_accessor :option
    end

    attr_reader :client

    def initialize(client: nil)
      @client = client
    end

    def receive
      @client.
        find(keys: %w(NOT SEEN)).
        map { |message| Kiki::Mail.new(message) }
    end

    def configure
      config = Config.new
      yield config
      @client = Receiver.create_client(config)
    end

    class << self
      def build
        receiver = new
        sub_receivers.push(receiver)
        receiver
      end

      def configure
        config = Config.new
        yield config
        @receiver = create_client(config)
      end

      def create_client(config)
        retriever = parser.lookup_retriever_method(config.protocol)
        new(client: retriever.new(config.option))
      end

      def receive
        receivers.
          map(&:receive).
          flatten.
          sort { |a, b| a.date <=> b.date }
      end

      def reset
        @receiver      = nil
        @sub_receivers = nil
        @receivers     = nil
      end

      private

      def receivers
        @receivers ||= [@receiver].concat(sub_receivers)
      end

      def sub_receivers
        @sub_receivers ||= []
      end

      def parser
        ::Mail::Configuration.instance
      end
    end
  end
end
