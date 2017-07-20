module Rounders
  class Rounder
    DEFAULT_ENV = 'development'.freeze
    DEFAULT_INTERVAL = 10

    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def start
      setup
      polling
    end

    def store
      @store ||= Rounders.stores[Rounders::Application.config.store].new
    end

    private

    def bundle
      ::Bundler.require(:default, env)
    rescue ::Bundler::GemfileNotFound => e
      Rounders.logger.error e
      exit
    end

    def daemon
      Process.daemon(true, false) if options[:daemon]
    end

    def dotenv
      Dotenv.load if options[:dotenv]
    end

    def env
      ENV['ROUNDERS_ENV'] || DEFAULT_ENV
    end

    def handle(mails)
      Rounders.handlers.map { |handler| handler.dispatch(self, mails) }
    end

    def load_config
      Rounders::Application.config.load_path.each do |path|
        Pathname.glob(File.join(Dir.pwd, path)).each do |config|
          require_relative config
        end
      end
    end

    def polling
      loop do
        round
        sleep interval
      end
    end

    def pid
      path = options[:pid]
      return if path.nil?
      File.open(path, 'w') { |f| f.write(Process.pid) }
      at_exit { File.unlink(path) }
    end

    def round
      handle receive_mail
    end

    def receive_mail
      Rounders::Receivers::Receiver.receive
    end

    def setup
      Topping.build
      daemon
      dotenv
      pid
      bundle
      load_config
      Rounders::Plugins::PluginLoader.load_plugins
    end

    def interval
      DEFAULT_INTERVAL
    end
  end
end
