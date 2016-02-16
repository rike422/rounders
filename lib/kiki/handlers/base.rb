module Kiki
  module Handlers
    class Base
      class << self
        def inherited(child)
          # Kiki.handlers << child
        end

        def on(pattern, options = {})
          # actions << Action.new(pattern, options)
        end
      end
    end
  end
end
