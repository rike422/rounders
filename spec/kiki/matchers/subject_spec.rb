require 'spec_helper'

describe Kiki::Matchers::Subject do
  let(:described_class) { Kiki::Matchers::Subject }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [/subject Message/] }
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
    let(:message) { Mail.new(subject: 'This is a subject of the email') }
    it 'should return MatchData' do
      expect(message.subject).to receive(:match).with(arguments[0]).and_return message.subject.match(arguments[0])
      expect(described_instance.match(message)).to_not be_nil
    end
  end
end
