require 'spec_helper'

describe Kiki::Pluggable do
  before(:each) do
    allow_any_instance_of(Kiki::Pluggable).to receive(:load_path).and_return Pathname.new('spec/kiki/fixtures/plugins/workers')
  end
  let(:puluggable_class) do
    class Worker
      include Kiki::Pluggable
    end
    Worker
  end

  describe '.inherited' do
    let!(:mock_glob) do
      Pathname.glob('spec/kiki/fixtures/plugins/workers/*.rb')
    end
    it 'should load plugins of include class' do
      expect(Pathname).to receive(:glob).
        with("#{Kiki::Pluggable::PLUGIN_BASE_DIR_PATH}/workers/*.rb").
        and_return mock_glob
      puluggable_class
    end
  end
end
