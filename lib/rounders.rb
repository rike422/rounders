require 'rounders/version'

module Rounders
  # Your code goes here...
  CONFIG_DIR_PATH = File.join(Dir.pwd, 'config').freeze
  PLUGIN_DIR_PATH = File.join(Dir.pwd, 'plugins').freeze
  class << self
    def handlers
      @_handlers ||= []
    end

    def matchers
      @_matchers ||= {}
    end

    def receivers
      @_receivers ||= []
    end
  end
end

require 'thor'
require 'hanami/utils/blank'
require 'hanami/utils/string'
require 'dry-configurable'
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
require 'rounders/receivers/receiver'
require 'rounders/receivers/mail'
require 'rounders/rounder'
require 'rounders/brains/base'

require 'rounders/generators/generator'
require 'rounders/generators/app'
require 'rounders/generators/handler'
require 'rounders/generators/matcher'
