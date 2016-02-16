module Kiki
  module Actions
    class Base
      class << self
        attr_reader :mail

        def initialize(mail)
          @mail = mail
        end
      end
    end
  end
end
