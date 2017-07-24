$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'support/custom_matcher/delegate_matcher'
require 'support/custom_matcher/rawdata_matcher'

if ENV['CI']
  require 'simplecov'
  require 'coveralls'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter
    ]
  )
  SimpleCov.start do
    add_group 'lib', 'lib'
    add_filter '/vendor/'
  end
end

SPEC_ROOT = File.join(File.dirname(__FILE__))
require 'rounders'
require 'rounders/commands/sub_commands/generate'
require 'rounders/commands/local_command'
require 'rounders/commands/global_command'
require 'rounders/test/rspec'

RSpec.configure do |c|
  # fixture path for rounders
  c.rounders_fixture_path = File.join(File.dirname(__FILE__), 'fixtures')
end

if RUBY_VERSION < '1.9.3'
  ::Dir.glob(::File.expand_path('../support/*.rb', __FILE__)).each { |f| require File.join(File.dirname(f), File.basename(f, '.rb')) }
  ::Dir.glob(::File.expand_path('../support/**/*.rb', __FILE__)).each { |f| require File.join(File.dirname(f), File.basename(f, '.rb')) }
else
  ::Dir.glob(::File.expand_path('../support/*.rb', __FILE__)).each { |f| require_relative f }
  ::Dir.glob(::File.expand_path('../support/**/*.rb', __FILE__)).each { |f| require_relative f }
end
