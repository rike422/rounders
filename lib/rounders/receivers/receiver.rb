module Rounders
  module Receivers
    class Receiver
      class << self
        def inherited(child_class)
          child_class.include Rounders::Plugins::Pluggable
          child_class.extend Dry::Configurable
          Rounders.receivers << child_class
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
