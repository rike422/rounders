require 'spec_helper'

describe Rounders::Rounder do
  let(:described_class) { Rounders::Rounder }
  let(:described_instance) { described_class.new(arguments) }
  let(:arguments) { [] }

  describe '#store' do
    it 'should be return nil' do
      expect(described_instance.store[:empty_data]).to eq nil
    end
    it 'should be to sets and gets value' do
      described_instance.store[:data] = 'hogehoge'
      expect(described_instance.store[:data]).to eq 'hogehoge'
    end
  end

  describe '#start' do
    let(:arguments) { {} }
    it 'should start polling' do
      expect(described_instance).to receive(:polling)
      described_instance.start
    end

    describe 'setup' do
      before(:each) do
        allow(described_instance).to receive(:polling)
      end

      context 'when dotenv option is enable' do
        let(:arguments) { { 'dotenv': true } }
        it 'should load dotenv option' do
          expect(Dotenv).to receive(:load)
          described_instance.start
        end
      end
      context 'when dotenv option is disable' do
        let(:arguments) { { 'dotenv': false } }
        it 'should not load dotenv option' do
          expect(Dotenv).to_not receive(:load)
          described_instance.start
        end
      end
      context 'when daemon option is enable' do
        let(:arguments) { { 'daemon': true } }
        it 'should daemonize process' do
          expect(Process).to receive(:daemon)
          described_instance.start
        end
      end
      context 'when daemon option is disable' do
        let(:arguments) { { 'daemon': false } }
        it 'should not daemonize option' do
          expect(Process).to_not receive(:daemon)
          described_instance.start
        end
      end
      context 'when pid opion is disable' do
        let(:pid) { './tmp/pid.txt' }
        let(:arguments) { { 'pid': pid } }
        before do
          allow_any_instance_of(Object).to receive(:at_exit)
        end
        it 'should write pid to given file path' do
          file = double('file')
          expect(file).to receive(:write)
          expect(File).to receive(:open).with(pid, 'w').and_yield(file)
          described_instance.start
        end
      end
    end
  end
end
