module Rounders
  module Test
    module Fixture
      def read_raw_fixture(*path)
        File.open fixture_path(*path), 'rb', &:read
      end

      def read_mail_fixture(*path)
        ::Mail.read(fixture_path(*path))
      end

      private

      def fixture_path(*path)
        File.join(RSpec.configuration.rounders_fixture_path, *path) if defined?(RSpec)
      end
    end
  end
end
