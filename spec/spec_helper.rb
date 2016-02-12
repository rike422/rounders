$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kiki'
require 'simplecov'
SimpleCov.start

if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)

  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end
