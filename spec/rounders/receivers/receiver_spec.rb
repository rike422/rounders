require 'spec_helper'

describe Rounders::Receivers::Receiver do
  let(:described_class) { Rounders::Receivers::Receiver }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [] }
  let(:config) { Rounders::Receivers::Receiver::Config.new }
  let(:messages) do
    day = Date.today
    (1..10).map do |i|
      ::Mail.new(
        to: "someone#{i}@somewhere.com",
        body: "body_#{i}",
        subject: "subject#{i}",
        date: day - i
      )
    end
  end

  describe '.new' do
    subject { described_instance }
    it { is_expected.to be_a described_class }
  end
end
