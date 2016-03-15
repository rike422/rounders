require 'spec_helper'

describe Kiki::Mail do
  let(:described_class) { Kiki::Mail }
  let(:described_instance) { described_class.new(*arguments) }
  let(:mail) { Mail::Message.new }
  let(:arguments) { [mail] }

  describe '#body' do
    let(:body) { 'body message' }
    it 'should be forwadable @massage.body' do
      allow(mail).to receive(:body).and_return(body)
      expect(described_instance.body).to eql body
    end
  end

  describe '#cc' do
    let(:cc) { 'user1@users.com' }
    it 'should be forwadable @massage.cc' do
      allow(mail).to receive(:cc).and_return(cc)
      expect(described_instance.cc).to eql cc
    end
  end

  describe '#envelope_from' do
    let(:envelope_from) { 'user1@users.com' }
    it 'should be forwadable @massage.cc' do
      allow(mail).to receive(:envelope_from).and_return(envelope_from)
      expect(described_instance.envelope_from).to eql envelope_from
    end
  end

  describe '#date' do
    let(:date) { Date.today }
    it 'should be forwadable @massage.date' do
      allow(mail).to receive(:date).and_return(date)
      expect(described_instance.date).to eql date
    end
  end

  describe '#from' do
    let(:from) { 'user1@users.com' }
    it 'should be forwadable @massage.from' do
      allow(mail).to receive(:from).and_return(from)
      expect(described_instance.from).to eql from
    end
  end

  describe '#sender' do
    let(:sender) { 'akira.takahashi' }
    it 'should be forwadable @massage.sender' do
      allow(mail).to receive(:sender).and_return(sender)
      expect(described_instance.sender).to eql sender
    end
  end

  describe '#subject' do
    let(:subject) { 'subject1' }
    it 'should be forwadable @massage.subject' do
      allow(mail).to receive(:subject).and_return(subject)
      expect(described_instance.subject).to eql subject
    end
  end

  describe '#forward' do
  end

  describe '#reply' do
  end
end
