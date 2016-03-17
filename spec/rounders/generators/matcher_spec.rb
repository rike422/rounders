require 'spec_helper'

describe Rounders::Generators::Matcher do
  let(:described_class) { Rounders::Generators::Matcher }
  let(:described_instance) { described_class.new(arguments) }
  let(:arguments) do
    { name: name }
  end
  let(:name) { 'my_matcher' }
  describe '.new' do
    subject { described_instance }
    it { is_expected.to be_a described_class }
    context 'with matcher methods' do
      let(:matchers) { %w(handle_method1 handle_method2) }
      let(:arguments) do
        { name: name }
      end
      it 'should assignment @name' do
        expect(described_instance.name).to eql name
      end
    end
  end
end
