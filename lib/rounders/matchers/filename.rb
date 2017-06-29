module Rounders
  module Matchers
    class Filename < Rounders::Matchers::Matcher
      attr_reader :pattern

      def initialize(pattern)
        @pattern = pattern
      end

      def match(message)
        return if message.attachment?
        matches = message.attachments.map do |attachment|
          match = attachment.filename.match(pattern)
          match.nil? ? nil : attachment
        end
        matches.compact
      end
    end
  end
end
