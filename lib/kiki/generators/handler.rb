module Kiki
  module Generators
    class Handler < Generator
      attr_accessor :handlers

      def initialize(name: nil, handlers: [])
        super(name)
        @handlers = handlers
      end
    end
  end
end
