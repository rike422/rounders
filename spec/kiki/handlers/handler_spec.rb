require 'spec_helper'

describe Kiki::Handlers::Handler do
  let(:described_class) { Kiki::Handlers::Handler }
  let(:described_instance) { described_class.new(*arguments) }
  let(:rounder) { Kiki::Rounder.new }
  let(:arguments) { [rounder, MatchData] }
  let(:mock_handler_class) do
    Class.new(Kiki::Handlers::Handler) do
      on({
           from: 'from_someone@somewhere.com',
           to:   'someone@somewhere.com'
         }, :my_callback)

      def my_callback
        true
      end
    end
  end

  describe '#initialize' do
    subject { described_instance }
    it { is_expected.to be_a described_class }
  end

  describe '.on' do
    let(:mail) do
      Kiki::Mail.new(
        ::Mail.new(
          to:      'someone@somewhere.com',
          body:    'body_message',
          subject: 'subject'
        )
      )
    end
    it 'should register a dispatcher to handler' do
      expect_any_instance_of(mock_handler_class).to receive(:my_callback).with(mail)
      mock_handler_class.dispatch(rounder, mail)
    end
  end
end
