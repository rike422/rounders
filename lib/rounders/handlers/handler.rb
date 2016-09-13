module Rounders
  module Handlers
    class Handler
      include Rounders::Plugins::Pluggable
      attr_reader :matches, :rouder
      class << self
        class Dispatcher
          attr_reader :matcher, :method_name

          def initialize(method_name, matcher)
            @matcher     = matcher
            @method_name = method_name
          end
        end

        def inherited(child_class)
          Rounders.handlers << child_class
        end

        def dispatch(rounder, mails)
          mails.map do |mail|
            dispatchers.each do |dispatcher|
              matches = dispatcher.matcher.match(mail)
              next if matches.nil?
              new(rounder, matches).public_send(dispatcher.method_name, mail)
            end
          end
        end

        def on(option, method_name)
          matcher = Rounders::Matchers::Matcher.build(option)
          dispatchers << Dispatcher.new(method_name, matcher)
        end

        private

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
