require 'hanami/utils/blank'
require 'hanami/utils/string'

module Rounders
  class Util
    class << self
      def infrect(str)
        Hanami::Utils::String.new(str)
      end

      def blank?(obj)
        Hanami::Utils::Blank.blank?(obj)
      end

      def present?(obj)
        !blank?(obj)
      end
    end
  end
end
