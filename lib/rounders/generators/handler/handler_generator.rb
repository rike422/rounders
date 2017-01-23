module Rounders
  module Generators
    class HandlerGenerator < Base
      desc 'handler <name> [<handlers>...]'
      argument :handlers, type: :array

      def set_destination_root
        self.destination_root = feature_path
      end

      def create_handler
        template '%underscored_name%_handler.rb.tt'
      end
    end
  end
end
