module Rounders
  module Receivers
    class Receiver
      include Topping::Configurable::Branch

      class << self
        def inherited(klass)
          super
          klass.include Rounders::Plugins::Pluggable
          Rounders.receivers << klass
        end

        def receive
          Rounders.
            receivers.
            map(&:receive).
            flatten.
            sort_by(&:date)
        end
      end
    end
  end
end
