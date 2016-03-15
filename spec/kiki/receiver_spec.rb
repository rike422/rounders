require 'spec_helper'

describe Kiki::Receiver do
  let(:described_class) { Kiki::Receiver }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [] }
  let(:config) { Kiki::Receiver::Config.new }
  let(:messages) do
    (1..10).map do |i|
      ::Mail.new(
        to:      "someone#{i}@somewhere.com",
        body:    "body_#{i}",
        subject: "subject#{i}",
        date:    i.days.ago
      )
    end
  end
  before(:each) do
    described_class.reset
  end
  describe '.configure' do
    it 'should yield with Kiki::Receiver::Config' do
      expect(described_class).to receive(:create_client).with(be_a(Kiki::Receiver::Config))
      expect { |b| described_class.configure(&b) }.to yield_with_args(Kiki::Receiver::Config)
    end
  end

  describe '.create_client' do
    before(:each) do
      config.protocol            = :pop3
      config.mail_server_settings = {
        address:        'localhost',
        port:           110,
        user_name:      'rike422',
        password:       nil,
        authentication: nil,
        enable_ssl:     true
      }
    end
    let(:retriever) { Mail::POP3 }
    it 'should call Mail::Configuration::lookup_retriever_method' do
      expect_any_instance_of(::Mail::Configuration).to receive(:lookup_retriever_method).with(config.protocol).and_call_original
      expect(described_class.create_client(config)).to be_a described_class
    end
    it 'should create Mail::Retriever with' do
      expect(retriever).to receive(:new).with(config.mail_server_settings)
      allow_any_instance_of(Mail::Configuration).to receive(:lookup_retriever_method).and_return(retriever)
      described_class.create_client(config)
    end
  end

  describe '.new' do
    subject { described_instance }
    it { is_expected.to be_a described_class }
  end

  describe '.receive' do
    let(:receiver) do
      retriever = ::Mail::POP3.new({})
      allow(retriever).to receive(:find).and_return messages
      Kiki::Receiver.new(client: retriever)
    end
    before(:each) do
      described_class.instance_variable_set(:@receiver, receiver)
    end
    subject { described_class.receive }
    it { is_expected.to be_a Array }
    it { is_expected.to all be_a(Kiki::Mail) }
    it 'should return Kiki::Mail, that sort_by date asc' do
      expect(described_class.receive.map(&:date)).to eq messages.reverse.map(&:date)
      described_class.receive.map(&:date)
    end
  end

  describe '#configure' do
    it 'should yield with Kiki::Receiver::Config' do
      spy = instance_spy('client')
      expect(described_class).to receive(:create_client).with(be_a(Kiki::Receiver::Config)).and_return spy
      expect { |b| described_instance.configure(&b) }.to yield_with_args(Kiki::Receiver::Config)
      expect(described_instance.client).to eq spy
    end
  end

  describe '#receive' do
    let(:client) { ::Mail::POP3.new({}) }
    let(:arguments) do
      [
        { client: client }
      ]
    end
    before(:each) do
      allow(client).to receive(:find).and_return(messages)
    end
    subject { described_instance.receive }
    it { is_expected.to be_a Array }
    it { is_expected.to all be_a(Kiki::Mail) }
    it 'should find unread email' do
      expect(client).to receive(:find).with(keys: %w(NOT SEEN))
      described_instance.receive
    end
  end
end
