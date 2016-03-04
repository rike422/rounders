module Kiki
  module Handlers
    class Handler
      attr_reader :matches, :rouder

      class << self
        class Dispatcher
          attr_reader :matcher, :method_name

          def initialize(method_name, matcher)
            @matcher     = matcher
            @method_name = method_name
          end
        end

        def dispatch(rounder, mail)
          dispatchers.each do |dispatcher|
            matches = dispatcher.matcher.match(mail)
            next if matches.blank?
            new(rounder, matches).my_callback mail
          end
        end

        def on(option, method_name)
          matcher = Kiki::Matchers::Matcher.build(option)
          dispatchers << Dispatcher.new(method_name, matcher)
        end

        private

        def inherited(child_class)
          handlers << child_class
        end

        def handlers
          @_handlers ||= []
        end

        def dispatchers
          @dispatchers ||= []
        end
      end

      def initialize(rounder, matches)
        @rounder = rounder
        @matches = matches
      end
    end
  end
end
