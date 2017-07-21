module Rounders
  module Receivers
    class Mail < Rounders::Receivers::Receiver
      config :protocol, default: :imap, required: true
      config :options, default: {}, required: true
      config :mail_server_setting, default: {}, required: true

      DEFAULT_FIND_OPTION = {
        keys: %w[NOT SEEN]
      }.freeze

      def client
        return @client if @client
        retriever = Rounders::Receivers::Mail.parser.lookup_retriever_method(config.protocol)
        @client = retriever.new(config.mail_server_setting)
      end

      def options
        @options ||= DEFAULT_FIND_OPTION.merge(config.options)
      end

      def receive
        client.find(options).map { |message| Rounders::Mail.new(message) }
      end

      class << self
        def create
          new
        end

        def receive
          @receiver ||= create
          @receiver.receive
        end

        def parser
          ::Mail::Configuration.instance
        end
      end
    end
  end
end
