require 'kiki/version'

module Kiki
  # Your code goes here...
end

require 'mail'
require 'slop'
require 'forwardable'

require 'kiki/configuration'
require 'kiki/commander'
require 'kiki/mail'
require 'kiki/receiver'
require 'kiki/rounder'
require 'kiki/actions/base'
require 'kiki/brains/base'
require 'kiki/handlers/base'

require 'kiki/matchers/matcher'
require 'kiki/matchers/subject'
require 'kiki/matchers/body'
require 'kiki/matchers/cc'
require 'kiki/matchers/from'
require 'kiki/matchers/to'
