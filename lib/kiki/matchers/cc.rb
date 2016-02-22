module Kiki
  module Matchers
    class CC < Kiki::Matchers::Matcher
      attr_reader :pattern

      def initialize(pattern)
        @pattern = pattern
      end

      def match(message)
        matches = message.cc.map do |address|
          address.match(pattern)
        end
        matches.compact
      end
    end
  end
end
