require 'spec_helper'

describe Rounders::Receivers::Mail do
  let(:described_class) { Rounders::Receivers::Mail }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [] }
  let(:messages) do
    day = Date.today
    (1..10).map do |i|
      ::Mail.new(
        to: "someone#{i}@somewhere.com",
        body: "body_#{i}",
        subject: "subject#{i}",
        date: day - i
      )
    end
  end
  let(:protocol) { :pop3 }
  let(:mail_server_setting) do
    {
      address: 'localhost',
      port: 110,
      user_name: 'rike422',
      password: nil,
      authentication: nil,
      enable_ssl: true
    }
  end
  let(:options) do
    {
      count: 30
    }
  end
  before(:each) do
    described_class.configure do |config|
      config.protocol = protocol
      config.mail_server_setting = mail_server_setting
      config.options = options
    end
  end

  describe '.create' do
    let(:retriever) { Mail::POP3 }
    it 'should create Mail::Retriever with' do
      expect(described_class.create).to be_a described_class
    end
  end

  describe '#receive' do
    let(:client) { ::Mail::POP3.new({}) }
    let(:options) do
      {
        count: 30,
        delete_after_find: true
      }
    end
    before(:each) do
      allow(described_instance).to receive(:client).and_return(client)
      allow(client).to receive(:find).and_return(messages)
    end
    subject { described_instance.receive }
    it { is_expected.to be_a Array }
    it { is_expected.to all be_a(Rounders::Mail) }
    it 'should find unread email' do
      expect(client).to receive(:find).with(
        keys: %w[NOT SEEN],
        count: options[:count],
        delete_after_find: options[:delete_after_find]
      )
      described_instance.receive
    end
  end
end
