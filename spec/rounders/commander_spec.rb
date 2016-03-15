require 'spec_helper'

describe Rounders::Commander do
  let(:described_class) { Rounders::Commander }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [] }

  describe '.new' do
    subject { described_instance }
    it { is_expected.to be_a described_class }
  end
end
