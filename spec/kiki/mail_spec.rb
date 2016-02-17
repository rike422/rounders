require 'spec_helper'

describe Kiki::Mail do
  let(:described_class) { Kiki::Mail }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [] }

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

  describe '#from' do
    let(:from) { 'user1@users.com' }
    it 'should be forwadable @massage.from' do
      allow(mail).to receive(:from).and_return(from)
      expect(described_instance.from).to eql from
    end
  end

  describe '#forward' do
  end

  describe '#reply' do
  end
end
