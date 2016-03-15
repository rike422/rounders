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

    def handle(mails)
      Kiki.handlers.map { |handler| handler.dispatch(self, mails) }
    end

    def load_config
      Pathname.glob(File.join(Dir.pwd, 'config/initializers/*.rb')).each do |config|
        require_relative config
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
