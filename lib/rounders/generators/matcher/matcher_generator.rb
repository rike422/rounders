module Rounders
  module Generators
    class MatcherGenerator < Base
      desc 'matcher <name>'

      def set_destination_root
        self.destination_root = feature_path
      end

      def create_matcher
        template '%underscored_name%_matcher.rb.tt'
      end
    end
  end
end
