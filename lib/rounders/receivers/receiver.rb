module Rounders
  module Receivers
    class Receiver
      class << self
        def create_client(config)
          retriever = parser.lookup_retriever_method(config.protocol)
          new(
            client: retriever.new(config.mail_server_settings),
            find_options: config.find_options
          )
        end

        def inherited(child_class)
          child_class.include Rounders::Plugins::Pluggable
          child_class.extend Dry::Configurable
          Rounders.receivers << child_class
        end

        def receive
          Rounders.
            receivers.
            map(&:receive).
            flatten.
            sort_by(&:date)
        end
      end
    end
  end
end
