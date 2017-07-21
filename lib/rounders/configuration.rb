module Rounders
  class DefaultConfiguration
    extend Topping::Configurable::HQ

    config :load_path,  required: true, default: [
      'config/initializers/*.rb'
    ]

    config :app_path, required: true, default: 'app', type: String

    # logger is the logger that will be used for Rounders.logger
    config :logger, required: true, default: Rounders::Logger.get_logger

    # Use temporaly store
    config :store, required: true, default: :memory, type: Symbol
  end
end
