module Rounders
  module Generators
    class ReceiverGenerator < Base
      desc 'receiver <name>'

      def set_destination_root
        self.destination_root = feature_path
      end

      def create_receiver
        template '%underscored_name%_receiver.rb.tt'
      end
    end
  end
end
