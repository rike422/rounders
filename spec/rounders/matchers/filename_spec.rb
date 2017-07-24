require 'spec_helper'

describe Rounders::Matchers::Filename do
  let(:described_class) { Rounders::Matchers::Filename }
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
    let(:arguments) { [/jpg/] }
    let(:jpg) { read_raw_fixture(%w[attachments test.jpg]) }
    let(:gif) { read_raw_fixture(%w[attachments test.gif]) }
    let(:zip) { read_raw_fixture(%w[attachments test.zip]) }
    let(:message) do
      mail = read_mail_fixture(%w[emails plain_text.eml])
      mail.attachments['test.jpg'] = jpg
      mail.attachments['test.zip'] = zip
      mail.attachments['test.gif'] = gif
      Rounders::Mail.new mail
    end
    it 'should return mached files' do
      expect(described_instance.match(message).first.decoded).to_not be_nil
      expect(described_instance.match(message).first.decoded).to eq_attachments jpg
    end
  end
end
