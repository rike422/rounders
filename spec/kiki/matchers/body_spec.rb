require 'spec_helper'

describe Kiki::Matchers::Body do
  let(:described_class) { Kiki::Matchers::Body }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [/body Message/] }
  describe '#inherited' do
    subject { described_class.superclass }
    it { is_expected.to eq Kiki::Matchers::Matcher }
  end

  describe '.new' do
    subject { described_instance }
    it { is_expected.to be_a described_class }

    context 'missing pattern' do
      let(:arguments) do
        {}
      end
      it 'should raise ArgumentError' do
        expect { described_instance }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#match' do
    let(:arguments) { [/email/] }
    let(:message) { Mail.new(body: 'This is a body of the email') }
    it 'should return MatchData' do
      expect(message.body).to receive_message_chain(:to_s, :force_encoding, :match).with(arguments[0]).and_return message.body.match(arguments[0])
      expect(described_instance.match(message)).to_not be_nil
    end
    context 'when message.body is nil' do
      let(:message) { Kiki::Mail.new(Mail.new) }
      it 'should return nil' do
        expect(described_instance.match(message)).to be_nil
      end
    end
  end
end
