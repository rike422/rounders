require 'spec_helper'

describe Rounders::Brains::Base do
  let(:described_class) { Rounders::Brains::Base }
  let(:described_instance) { described_class.new(*args) }
  let(:args) { [] }

  describe '#initialize' do
    subject { described_instance }
    it { is_expected.to be_a described_class }
  end
end
