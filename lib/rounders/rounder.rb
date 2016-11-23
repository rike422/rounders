module Rounders
  class Rounder
    DEFAULT_ENV = 'development'.freeze
    DEFAULT_INTERVAL = 10

    def dotenv
      Dotenv.load
    end

    def start
      setup
      polling
    end

    private

    def bundle
      ::Bundler.require(:default, env)
    rescue ::Bundler::GemfileNotFound => e
      puts e
      exit
    end

    def env
      ENV['ROUNDERS_ENV'] || DEFAULT_ENV
    end

    def handle(mails)
      Rounders.handlers.map { |handler| handler.dispatch(self, mails) }
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
      Rounders::Receivers::Receiver.receive
    end

    def setup
      bundle
      load_config
      Rounders::Plugins::PluginLoader.load_plugins
    end

    def interval
      DEFAULT_INTERVAL
    end
  end
end
