module Kiki
  class Rounder
    DEFAULT_INTERVAL = 100

    def dotenv
      Dotenv.load
    end

    def start
      setup
      polling
    end

    private

    def load_config
      Pathname.glob('./config/initializers/*.rb').each do |config|
        require config
      end
    end

    def polling
      loop do
        round
        sleep interval
      end
    end

    def round
      handle receive_mail
    end

    def handle(mails)
      Handler.handlers.map { |handler| handler.dispatch(self, mails) }
    end

    def receive_mail
      Kiki::Receiver.receive
    end

    def setup
      load_config
      Kiki::Plugins::PluginLoader.load_plugins
    end

    def interval
      DEFAULT_INTERVAL
    end
  end
end
