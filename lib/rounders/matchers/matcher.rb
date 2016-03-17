module Rounders
  module Matchers
    class NoImplementError < StandardError
    end
    class Matcher
      include Rounders::Plugins::Pluggable
      attr_reader :matchers

      def initialize(matchers)
        @matchers = matchers
      end

      def match(message)
        match_data = matchers.each_with_object({}) do |matcher, memo|
          memo[matcher.class.symbol] = matcher.match(message)
        end
        return match_data if match_data.values.all?(&:present?)
        nil
      end

      class << self
        def inherited(klass)
          Rounders.matchers[klass.symbol] = klass
        end

        def symbol
          name.demodulize.underscore.to_sym
        end

        def build(conditions)
          matchers = conditions.map do |key, pattern|
            matcher = Rounders.matchers[key]
            raise Rounders::Matchers::NoImplementError if matcher.blank?
            matcher.new(pattern)
          end
          new(matchers)
        rescue StandardError => e
          raise e
        end
      end
    end
  end
end
