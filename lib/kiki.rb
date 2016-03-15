require 'kiki/version'

module Kiki
  # Your code goes here...
  CONFIG_DIR_PATH = File.join(Dir.pwd, 'config').freeze
  PLUGIN_DIR_PATH = File.join(Dir.pwd, 'plugins').freeze
end

require 'active_support/core_ext/object'
require 'active_support/inflector'
require 'thor'
require 'forwardable'
require 'mail'
require 'dotenv'

require 'kiki/mail'
require 'kiki/plugins/plugin_loader'
require 'kiki/plugins/pluggable'
require 'kiki/matchers/matcher'
require 'kiki/matchers/subject'
require 'kiki/matchers/body'
require 'kiki/matchers/cc'
require 'kiki/matchers/from'
require 'kiki/matchers/to'
require 'kiki/handlers/handler'
require 'kiki/commander'
require 'kiki/receiver'
require 'kiki/rounder'
require 'kiki/brains/base'

require 'kiki/generators/generator'
require 'kiki/generators/app'
require 'kiki/generators/handler'
