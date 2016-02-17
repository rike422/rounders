require 'spec_helper'

describe Kiki::Receiver do
  let(:described_class) { Kiki::Receiver }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [] }

  describe '.new' do
    subject { described_instance }
    it { is_expected.to be_a described_class }
  end

  describe '#receive' do
  end
end
