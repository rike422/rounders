$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
if ENV['CIRCLE_ARTIFACTS']
  require 'simplecov'
  require 'coveralls'
  require 'codeclimate-test-reporter'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
  SimpleCov.start do
    add_group 'lib', 'lib'
    add_filter '/vendor/'
  end
  CodeClimate::TestReporter.start
end

require 'rounders'
