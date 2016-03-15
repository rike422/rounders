module Kiki
  module Matchers
    class From < Kiki::Matchers::Matcher
      attr_reader :pattern

      def initialize(pattern)
        @pattern = pattern
      end

      def match(message)
        return if message.from.nil?
        matches = message.from.map do |address|
          address.match(pattern)
        end
        matches.compact
      end
    end
  end
end
