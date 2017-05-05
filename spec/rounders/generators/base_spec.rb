require 'spec_helper'

describe Rounders::Generators::Base do
  let(:described_class) { Rounders::Generators::Base }
  let(:described_instance) { described_class.new(*arguments) }
  let(:name) { 'test_generator' }
  let(:arguments) { [name] }
  let(:generator_class) do
    module Mock
      class Worker < Rounders::Generators::Base; end
    end
    Mock::Worker
  end

  describe '#output_path' do
    it 'should return directory path' do
      # expect(generator_instance.send(:output_path)).to be_a Pathname
      # expect(generator_instance.send(:output_path).to_s).to eq File.join(Dir.pwd, 'app/workers')
    end
  end
end
