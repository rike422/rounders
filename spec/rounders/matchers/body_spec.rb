require 'spec_helper'

describe Rounders::Matchers::Body do
  let(:described_class) { Rounders::Matchers::Body }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [/body Message/] }
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
    context 'when plain text mail' do
      let(:arguments) { [/テキストメールのテストです/] }
      let(:message) { Rounders::Mail.new read_fixture(%w[emails plain_text.eml]) }
      it 'should return MatchData' do
        expect(described_instance.match(message)).to_not be_nil
        expect(described_instance.match(message).to_s).to eq 'テキストメールのテストです'
      end
    end
    context 'when multipart mail' do
      let(:arguments) { [/テストメールです/] }
      let(:message) { Rounders::Mail.new read_fixture(%w[emails multi_part.eml]) }
      it 'should return MatchData' do
        expect(described_instance.match(message)).to_not be_nil
        expect(described_instance.match(message).to_s).to eq 'テストメールです'
      end
    end
    context 'when message.body is nil' do
      let(:message) { Rounders::Mail.new(Mail.new) }
      it 'should return nil' do
        expect(described_instance.match(message)).to be_nil
      end
    end
  end
end
