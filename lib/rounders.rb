require 'rounders/version'

module Rounders
  # Your code goes here...
  CONFIG_DIR_PATH = File.join(Dir.pwd, 'config').freeze
  PLUGIN_DIR_PATH = File.join(Dir.pwd, 'plugins').freeze
  class << self
    def handlers
      @handlers ||= []
    end

    def matchers
      @matchers ||= {}
    end
  end
end

require 'active_support/core_ext/object'
require 'active_support/inflector'
require 'thor'
require 'forwardable'
require 'mail'
require 'dotenv'

require 'rounders/mail'
require 'rounders/plugins/plugin_loader'
require 'rounders/plugins/pluggable'
require 'rounders/matchers/matcher'
require 'rounders/matchers/subject'
require 'rounders/matchers/body'
require 'rounders/matchers/cc'
require 'rounders/matchers/from'
require 'rounders/matchers/to'
require 'rounders/handlers/handler'
require 'rounders/commander'
require 'rounders/receiver'
require 'rounders/rounder'
require 'rounders/brains/base'

require 'rounders/generators/generator'
require 'rounders/generators/app'
require 'rounders/generators/handler'
require 'rounders/generators/matcher'
