require 'spec_helper'

describe Kiki::Commander do
  let(:described_class) { Kiki::Commander }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [] }

  describe '.new' do
    subject { described_instance }
    it { is_expected.to be_a described_class }
  end

  describe '#excute' do
    context 'when enabled help option' do
      let(:argv_mock) do
        {
          help: true
        }
      end
      before(:each) do
        allow_any_instance_of(described_class).to receive(:argv).
          and_return argv_mock
        allow_any_instance_of(described_class).to receive(:exit).
          and_return nil
      end
      it 'should be display help message' do
        expect(described_instance).to receive(:puts).
          with(described_instance.send(:argv))

        described_instance.execute
      end
    end
  end

  describe '#argv' do
    before(:each) do
      ARGV.clear
    end
    it 'should support help command' do
      expect_any_instance_of(Slop::Options).to receive(:on).
        with('-h', '--help', 'Display this help message.')
      described_instance.send(:argv)
    end
  end
end
