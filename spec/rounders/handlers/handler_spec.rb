require 'spec_helper'

describe Rounders::Handlers::Handler do
  let(:described_class) { Rounders::Handlers::Handler }
  let(:described_instance) { described_class.new(*arguments) }
  let(:rounder) { Rounders::Rounder.new }
  let(:arguments) { [rounder] }
  let(:mock_handler_class) do
    module Rounders
      module Handlers
        class MockHandler < Rounders::Handlers::Handler
          on({ to: 'to_someone1@somewhere.com' }, :to_callback)
          on({ from: 'from_someone_unknown@somewhere.com' }, :from_callback)
          on({ body: 'body_message2' }, :body_callback)

          def from_callback(mail, _match)
            mail
          end

          def to_callback(mail, _match)
            mail
          end

          def body_callback(mail, _match)
            mail
          end
        end
      end
    end
  end

  describe '#initialize' do
    subject { described_instance }
    it { is_expected.to be_a described_class }
  end

  describe '.inherited' do
    it 'should add to Rounders.handlers' do
      expect { mock_handler_class }.to change { Rounders.handlers.length }.by(+1)
    end
  end

  describe '.on' do
    let(:mock_handler_class) { Rounders::Handlers::MockHandler }
    let(:mails) do
      (1..3).map do |i|
        Rounders::Mail.new(
          ::Mail.new(
            to: "to_someone#{i}@somewhere.com",
            from: "from_someone#{i}@somewhere.com",
            body: "body_message#{i}"
          )
        )
      end
    end
    it 'should register a dispatcher to handler' do
      expect_any_instance_of(mock_handler_class).to receive(:to_callback).with(
        mails[0], to: [/to_someone1@somewhere.com/.match('to_someone1@somewhere.com')]
      )
      expect_any_instance_of(mock_handler_class).to receive(:body_callback).with(
        mails[1],
        body: /body_message2/.match('body_message2')
      )
      expect_any_instance_of(mock_handler_class).to_not receive(:from_callback)
      mock_handler_class.dispatch(rounder, mails)
    end
  end
end
