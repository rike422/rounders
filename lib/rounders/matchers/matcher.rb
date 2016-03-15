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
          memo[matcher.class.name.demodulize.underscore.to_sym] = matcher.match(message)
        end
        return match_data if match_data.values.all?(&:present?)
        nil
      end

      class << self
        def build(conditions)
          matchers = conditions.map do |key, pattern|
            matcher = "#{name.deconstantize}::#{key.to_s.classify}".constantize
            matcher.new(pattern)
          end
          new(matchers)
        rescue NameError
          raise Rounders::Matchers::NoImplementError
        rescue StandardError => e
          raise e
        end
      end
    end
  end
end
