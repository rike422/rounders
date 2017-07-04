require 'spec_helper'

describe Rounders::Stores::Store do
  let(:described_class) { Rounders::Stores::Store }
  let(:described_instance) { described_class.new(*args) }
  let(:args) { [] }

  let(:test_class) do
    class MockStore < Rounders::Stores::Store
      def data
        @data ||= {}
      end
    end
    MockStore.new
  end

  describe '#initialize' do
    subject { described_instance }
    it { is_expected.to be_a described_class }
  end

  describe 'data' do
    it 'should be return nil' do
      expect(test_class[:empty_data]).to eq nil
    end
    it 'should be to sets and gets value' do
      test_class[:data] = 'hogehoge'
      expect(test_class[:data]).to eq 'hogehoge'
    end
  end
end
