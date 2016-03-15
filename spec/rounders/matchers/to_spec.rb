require 'spec_helper'

describe Rounders::Matchers::To do
  let(:described_class) { Rounders::Matchers::To }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [/@github.com/] }
  let(:to_addresses) do
    [
      'user1@github.com',
      'customer2@github.com',
      'publisher@rubygems.com'
    ]
  end

  describe '#inherited' do
    subject { described_class.superclass }
    it { is_expected.to eq Rounders::Matchers::Matcher }
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
    context 'when Message.to.addresses is a Array' do
      let(:arguments) do
        [
          /github.com/
        ]
      end
      let(:message) do
        Mail.new(to: to_addresses)
      end
      it 'should return Array of MatchData' do
        expect(described_instance.match(message)).to be_a(Array)
        expect(described_instance.match(message)).to all be_a(MatchData)
      end
    end
    context 'when Message.to is a String' do
      let(:arguments) do
        [
          /github.com/
        ]
      end
      let(:message) do
        Mail.new(to: 'rike422@github.com')
      end
      it 'should return Array of MatchData' do
        expect(described_instance.match(message)).to be_a(Array)
        expect(described_instance.match(message)).to all be_a(MatchData)
      end
    end
    context 'when Message.to is nil' do
      let(:message) do
        Rounders::Mail.new(
          Mail.new
        )
      end
      it 'should return nil' do
        expect(described_instance.match(message)).to be_nil
      end
    end
  end
end
