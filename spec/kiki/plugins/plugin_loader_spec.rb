require 'spec_helper'

describe Kiki::Plugins::PluginLoader do
  let(:described_class) { Kiki::Plugins::PluginLoader }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [] }
  let!(:mock_class) do
    class MockClass
      def self.load_plugins
      end
    end
    MockClass
  end

  let!(:mock_class2) do
    class MockClass2
      def self.load_plugins
      end
    end
    MockClass2
  end

  describe '.load_plugins' do
    before(:each) do
      described_class.register mock_class
      described_class.register mock_class2
    end
    it 'shoud load plugins' do
      expect(mock_class).to receive(:load_plugins)
      expect(mock_class2).to receive(:load_plugins)
      described_class.load_plugins
    end
  end
end
