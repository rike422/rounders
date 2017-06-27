module Rounders
  module Receivers
    class Mail < Rounders::Receivers::Receiver
      setting :protocol, :imap
      setting :options, {}
      setting :mail_server_setting
      DEFAULT_FIND_OPTION = {
        keys: %w[NOT SEEN]
      }.freeze

      def initialize(client: nil, options: {})
        @client = client
        @options = DEFAULT_FIND_OPTION.merge(options)
      end

      def receive
        @client.find(@options).map { |message| Rounders::Mail.new(message) }
      end

      class << self
        def create
          config = Mail.config
          retriever = parser.lookup_retriever_method(config.protocol)
          new(
            client: retriever.new(config.mail_server_setting),
            options: config.options
          )
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
