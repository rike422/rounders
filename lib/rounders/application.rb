module Rounders
  class Application
    extend Dry::Configurable

    setting :load_path, [
      'config/initializers/*.rb'
    ], reader: true

    setting :app_path, 'app', reader: true

    # logger is the logger that will be used for Rounders.logger
    setting :logger, Rounders::Logger.get_logger, reader: true

    setting :store, :memory, reader: true
  end
end
