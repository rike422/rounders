require 'spec_helper'

describe Rounders::Mail do
  let(:described_class) { Rounders::Mail }
  let(:described_instance) { described_class.new(*arguments) }
  let(:mail) { Mail::Message.new }
  let(:arguments) { [mail] }

  describe Rounders::Mail do
    subject { described_class.new(*arguments) }
    it { is_expected.to delegate(:all_parts).to(:@mail) }
    it { is_expected.to delegate(:attachment).to(:@mail) }
    it { is_expected.to delegate(:attachment?).to(:@mail) }
    it { is_expected.to delegate(:attachments).to(:@mail) }
    it { is_expected.to delegate(:bcc).to(:@mail) }
    it { is_expected.to delegate(:body).to(:@mail) }
    it { is_expected.to delegate(:body_encoding).to(:@mail) }
    it { is_expected.to delegate(:cc).to(:@mail) }
    it { is_expected.to delegate(:charset).to(:@mail) }
    it { is_expected.to delegate(:comments).to(:@mail) }
    it { is_expected.to delegate(:content_description).to(:@mail) }
    it { is_expected.to delegate(:content_id).to(:@mail) }
    it { is_expected.to delegate(:content_location).to(:@mail) }
    it { is_expected.to delegate(:content_transfer_encoding).to(:@mail) }
    it { is_expected.to delegate(:content_type).to(:@mail) }
    it { is_expected.to delegate(:date).to(:@mail) }
    it { is_expected.to delegate(:decode_body).to(:@mail) }
    it { is_expected.to delegate(:decoded).to(:@mail) }
    it { is_expected.to delegate(:default).to(:@mail) }
    it { is_expected.to delegate(:encoded).to(:@mail) }
    it { is_expected.to delegate(:envelope_date).to(:@mail) }
    it { is_expected.to delegate(:envelope_from).to(:@mail) }
    it { is_expected.to delegate(:filename).to(:@mail) }
    it { is_expected.to delegate(:from).to(:@mail) }
    it { is_expected.to delegate(:has_attachments?).to(:@mail) }
    it { is_expected.to delegate(:header).to(:@mail) }
    it { is_expected.to delegate(:headers).to(:@mail) }
    it { is_expected.to delegate(:html_part).to(:@mail) }
    it { is_expected.to delegate(:in_reply_to).to(:@mail) }
    it { is_expected.to delegate(:keywords).to(:@mail) }
    it { is_expected.to delegate(:main_type).to(:@mail) }
    it { is_expected.to delegate(:message_content_type).to(:@mail) }
    it { is_expected.to delegate(:message_id).to(:@mail) }
    it { is_expected.to delegate(:mime_parameters).to(:@mail) }
    it { is_expected.to delegate(:mime_type).to(:@mail) }
    it { is_expected.to delegate(:mime_version).to(:@mail) }
    it { is_expected.to delegate(:multipart_report?).to(:@mail) }
    it { is_expected.to delegate(:part).to(:@mail) }
    it { is_expected.to delegate(:parts).to(:@mail) }
    it { is_expected.to delegate(:sender).to(:@mail) }
    it { is_expected.to delegate(:sub_type).to(:@mail) }
    it { is_expected.to delegate(:subject).to(:@mail) }
    it { is_expected.to delegate(:text?).to(:@mail) }
    it { is_expected.to delegate(:text_part).to(:@mail) }
    it { is_expected.to delegate(:to).to(:@mail) }
  end

  describe '#text' do
    context 'when plain text mail' do
      let(:mail) { described_class.new(read_fixture(%w[emails plain_text.eml])) }
      it 'should return text part' do
        expect(mail.text).to eq "このメールはテキストメールのテストです。\r\n"
      end
    end
    context 'when multipart mail' do
      let(:mail) { described_class.new(read_fixture(%w[emails multi_part.eml])) }
      it 'should return text part' do
        expect(mail.text).to eq "*概要*\r\n\r\nこのメールはテストメールです\r\n"
      end
    end
  end

  describe '#forward' do
  end

  describe '#reply' do
  end
end
