module Rounders
  module Stores
    class Memory < Rounders::Stores::Store
      def data
        @data ||= {}
      end
    end
  end
end
