require 'rounders/version'

require 'thor'
require 'thor/group'
require 'dry-configurable'
require 'forwardable'
require 'mail'
require 'dotenv'

require 'rounders/logger'
require 'rounders/application'
require 'rounders/util'

module Rounders
  # Your code goes here...
  CONFIG_DIR_PATH = File.join(Dir.pwd, 'config').freeze
  APP_PATH = File.join(Dir.pwd, Rounders::Application.app_path).freeze

  class << self
    attr_accessor :logger

    def global?
      !Pathname(Rounders::APP_PATH).exist?
    end

    def handlers
      @_handlers ||= []
    end

    def matchers
      @_matchers ||= {}
    end

    def receivers
      @_receivers ||= []
    end

    def stores
      @_stores ||= {}
    end
  end

  self.logger = Rounders::Application.logger
end

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
require 'rounders/stores/store'
require 'rounders/stores/memory'

require 'rounders/generators/base'
require 'rounders/generators/app/app_generator'
require 'rounders/generators/plugin/plugin_generator'
require 'rounders/generators/handler/handler_generator'
require 'rounders/generators/matcher/matcher_generator'
require 'rounders/generators/receiver/receiver_generator'
