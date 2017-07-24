require_relative 'fixture'

RSpec.configure do |config|
  config.before(:each) do
    Topping.build
  end
  config.include Rounders::Test::Fixture
end

module Rounders
  module Rspec
    # Fake class to document RSpec Rails configuration options. In practice,
    # these are dynamically added to the normal RSpec configuration object.
    class Configuration
    end

    def self.initialize_configuration(config)
      # fixture support
      config.add_setting :rounders_fixture_path
    end

    # rubocop:enable Style/MethodLength
    initialize_configuration RSpec.configuration
  end
end
