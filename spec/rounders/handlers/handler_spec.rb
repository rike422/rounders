require 'spec_helper'

describe Rounders::Handlers::Handler do
  let(:described_class) { Rounders::Handlers::Handler }
  let(:described_instance) { described_class.new(*arguments) }
  let(:rounder) { Rounders::Rounder.new }
  let(:arguments) { [rounder, MatchData] }
  let(:mock_handler_class) do
    Class.new(Rounders::Handlers::Handler) do
      on({ to: 'to_someone1@somewhere.com' }, :to_callback)
      on({ from: 'from_someone_unknown@somewhere.com' }, :from_callback)
      on({ body: 'body_message2' }, :body_callback)

      def from_callback(mail)
        mail
      end

      def to_callback(mail)
        mail
      end

      def body_callback(mail)
        mail
      end
    end
  end

  describe '#initialize' do
    subject { described_instance }
    it { is_expected.to be_a described_class }
  end

  describe '.inherited' do
    let(:inherited_class) do
      Class.new(Rounders::Handlers::Handler) do
      end
    end
    it 'should add to Rounders.handlers' do
      expect { inherited_class }.to change { Rounders.handlers.length }.by(+1)
    end
  end

  describe '.on' do
    let(:mails) do
      (1..3).map do |i|
        Rounders::Mail.new(
          ::Mail.new(
            to:   "to_someone#{i}@somewhere.com",
            from: "from_someone#{i}@somewhere.com",
            body: "body_message#{i}"
          )
        )
      end
    end
    it 'should register a dispatcher to handler' do
      expect_any_instance_of(mock_handler_class).to receive(:to_callback).with(mails[0])
      expect_any_instance_of(mock_handler_class).to receive(:body_callback).with(mails[1])
      expect_any_instance_of(mock_handler_class).to_not receive(:from_callback)
      mock_handler_class.dispatch(rounder, mails)
    end
  end
end
