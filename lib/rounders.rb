require 'rounders/version'

module Rounders
  # Your code goes here...
  CONFIG_DIR_PATH = File.join(Dir.pwd, 'config').freeze
  APP_PATH = File.join(Dir.pwd, 'app').freeze
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

    def global?
      !Pathname(Rounders::APP_PATH).exist?
    end
  end
end

require 'thor'
require 'thor/group'
require 'dry-configurable'
require 'forwardable'
require 'mail'
require 'dotenv'

require 'rounders/util'
require 'rounders/mail'
require 'rounders/plugins/plugin_loader'
require 'rounders/plugins/pluggable'
require 'rounders/matchers/matcher'
require 'rounders/matchers/subject'
require 'rounders/matchers/body'
require 'rounders/matchers/cc'
require 'rounders/matchers/from'
require 'rounders/matchers/filename'
require 'rounders/matchers/to'
require 'rounders/handlers/handler'
require 'rounders/commander'
require 'rounders/receivers/receiver'
require 'rounders/receivers/mail'
require 'rounders/rounder'
require 'rounders/brains/base'

require 'rounders/generators/base'
require 'rounders/generators/app/app_generator'
require 'rounders/generators/plugin/plugin_generator'
require 'rounders/generators/handler/handler_generator'
require 'rounders/generators/matcher/matcher_generator'
require 'rounders/generators/receiver/receiver_generator'
