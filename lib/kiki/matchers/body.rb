module Kiki
  module Matchers
    class Body < Kiki::Matchers::Matcher
      attr_reader :pattern

      def initialize(pattern)
        @pattern = pattern
      end

      def match(mail)
        return if mail.body.nil?
        mail.body.match(pattern)
      end
    end
  end
end
