module Kiki
  module Generators
    class Handler < Generator
      def initialize(name: nil, argv: [])
        @name = name
        @argv = argv
      end
    end
  end
end
