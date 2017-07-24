module Rounders
  module Handlers
    class Handler
      include Rounders::Plugins::Pluggable
      include Topping::Configurable::Branch
      attr_reader :matches, :rounder

      class << self
        class Event
          attr_reader :matcher, :method_name, :event_class

          def initialize(event_class, method_name, matcher)
            @event_class = event_class
            @matcher = matcher
            @method_name = method_name
          end

          def call(mail, rounder)
            matches = match(mail)
            return if matches.nil?
            trigger(mail, rounder, matches)
          end

          private

          def match(mail)
            matcher.match(mail)
          end

          def trigger(mail, rounder, matches)
            event_class.new(rounder).public_send(method_name, mail, matches)
          end
        end

        def inherited(klass)
          super
          Rounders.handlers << klass
        end

        def dispatch(rounder, mails)
          mails.map do |mail|
            events.each { |event| event.call(mail, rounder) }
          end
        end

        def on(option, method_name)
          matcher = Rounders::Matchers::Matcher.build(option)
          events << Event.new(self, method_name, matcher)
        end

        private

        def events
          @events ||= []
        end
      end

      def initialize(rounder)
        @rounder = rounder
      end
    end
  end
end
