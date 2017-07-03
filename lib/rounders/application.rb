module Rounders
  class Application
    extend Dry::Configurable

    setting :load_path, [
      'config/initializers/*.rb'
    ], reader: true

    setting :app_path, 'app', reader: true
  end
end
