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

require 'rounders'
require 'rounders/commands/sub_commands/generate'
require 'rounders/commands/local_command'
require 'rounders/commands/global_command'
