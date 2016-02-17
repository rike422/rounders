require 'spec_helper'

describe Kiki::Handlers::Base do
  let(:described_class) { Kiki::Handlers::Base }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [] }

  describe '#initialize' do
    subject { described_instance }
    it { is_expected.to be_a described_class }
  end

  describe '#on' do
    # subject { described_instance.on(arguments) }
    # let(:arguments) do
    #   {
    #     from: 'hogehoge@mail.com',
    #     cc: ['hugahuga@mail.com']
    #   }
    # end
  end
end
