require 'spec_helper'

describe Rounders::Generators::Handler do
  let(:described_class) { Rounders::Generators::Handler }
  let(:described_instance) { described_class.new(arguments) }
  let(:arguments) do
    { name: name }
  end
  let(:name) { 'my_handler' }
  describe '.new' do
    subject { described_instance }
    it { is_expected.to be_a described_class }
    context 'with handler methods' do
      let(:handlers) { %w(handle_method1 handle_method2) }
      let(:arguments) do
        { name: name, handlers: handlers }
      end
      it 'should assignment @handlers' do
        expect(described_instance.handlers).to eql handlers
      end
    end
  end
end
