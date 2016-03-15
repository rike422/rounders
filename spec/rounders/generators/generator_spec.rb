require 'spec_helper'

describe Rounders::Generators::Generator do
  let(:described_class) { Rounders::Generators::Generator }
  let(:described_instance) { described_class.new(*arguments) }
  let(:name) { 'test_generator' }
  let(:arguments) { [name] }
  let(:generator_class) do
    module Mock
      class Worker < Rounders::Generators::Generator; end
    end
    Mock::Worker
  end
  let(:generator_instance) do
    generator_class.new(*arguments)
  end
  describe '#class_name' do
    subject { generator_instance.class_name }
    it { is_expected.to eql 'TestGenerator' }
  end
  describe '#output_path' do
    it 'should retrun directory path' do
      expect(generator_instance.send(:output_path)).to be_a Pathname
      expect(generator_instance.send(:output_path).to_s).to eq File.join(Dir.pwd, 'plugins/workers')
    end
  end
end
