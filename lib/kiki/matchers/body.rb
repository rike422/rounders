module Kiki
  module Matchers
    class Body < Kiki::Matchers::Matcher
      attr_reader :pattern

      def initialize(pattern)
        @pattern = pattern
      end

      def match(mail)
        return if mail.body.nil?
        mail.body.to_s.force_encoding('UTF-8').match(pattern)
      end
    end
  end
end
