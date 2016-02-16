require 'spec_helper'

describe Kiki::Matchers::Body do
  let(:described_class) { Kiki::Matchers::Body }
  let(:described_instance) { described_class.new(arguments) }
  let(:arguments) do
    {
      pattern: /body Message/
    }
  end

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
    let(:arguments) do
      {
        pattern: /rounder/
      }
    end
    let(:message) do
      instance_double('Message', body: "Hi! I'm rounder, Please give me some instructions!!")
    end
    it 'should retrun MatchData' do
      expect(described_incetane.match(message)).to_not be_nil
    end
  end
end
