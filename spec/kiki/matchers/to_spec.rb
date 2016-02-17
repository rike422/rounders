require 'spec_helper'

describe Kiki::Matchers::To do
  let(:described_class) { Kiki::Matchers::To }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [] }

  describe '#inherited' do
    subject { described_class }
    it { is_expected.to be_a Kiki::Matchers::Matcher }
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
    context 'when Message.to is a Array' do
      let(:arguments) do
        {
          pattern: /github.com/
        }
      end
      let(:message) do
        instance_double('Message', to: ['rike422@github.com', 'rike422+2@github.com'])
      end
      it 'should return Array of MatchData' do
        expect(described_incetane.match(message)).to_not be_a(Array)
        expect(described_incetane.match(message)).to all be_a(MatchData)
      end
    end
    context 'when Message.to be a string' do
      let(:arguments) do
        {
          pattern: /github.com/
        }
      end
      let(:message) do
        instance_double('Message', to: 'rike422@github.com')
      end
      it 'should return Array of MatchData' do
        expect(described_incetane.match(message)).to_not be_a(Array)
      end
    end
  end
end
