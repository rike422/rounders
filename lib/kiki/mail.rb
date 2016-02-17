require 'mail'

module Kiki
  class Mail
    def initialize(option)
      @mail = Mail.new(option)
    end
  end
end
