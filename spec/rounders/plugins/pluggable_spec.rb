require 'spec_helper'

describe Rounders::Plugins::Pluggable do
  before(:each) do
    allow_any_instance_of(Rounders::Plugins::Pluggable).to receive(:load_path).and_return Pathname.new('spec/rounders/fixtures/plugins/workers')
  end
  let(:puluggable_class) do
    class Worker
      include Rounders::Plugins::Pluggable
    end
    Worker
  end

  describe '.included' do
    let(:puluggable_class) do
      class Worker2
        include Rounders::Plugins::Pluggable
      end
      Worker2
    end
    it 'should register class to PluginLoader' do
      expect { puluggable_class }.to change { Rounders::Plugins::PluginLoader.send(:pluggable_classes).length }.by(+1)
    end
  end

  describe '.load_plguins' do
    let!(:mock_glob) do
      Pathname.glob('spec/rounders/fixtures/plugins/workers/*.rb')
    end
    it 'should load plugins of include class' do
      expect(Pathname).to receive(:glob).
        with("#{Rounders::PLUGIN_DIR_PATH}/workers/*.rb").
        and_return mock_glob
      puluggable_class.load_plugins
    end
  end
end
