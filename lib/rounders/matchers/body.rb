module Rounders
  module Matchers
    class Body < Rounders::Matchers::Matcher
      attr_reader :pattern

      def initialize(pattern)
        @pattern = pattern
      end

      def match(mail)
        mail.text.match(pattern)
      end
    end
  end
end
