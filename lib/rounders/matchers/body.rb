module Rounders
  module Matchers
    class Body < Rounders::Matchers::Matcher
      attr_reader :pattern

      def initialize(pattern)
        @pattern = pattern
      end

      def match(mail)
        if mail.multipart?
          mail.text_part.decoded.match(pattern)
        else
          mail.decoded.match(pattern)
        end
      end
    end
  end
end
