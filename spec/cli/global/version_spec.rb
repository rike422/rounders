require 'spec_helper'

describe Rounders::Commands::GlobalCommand, type: :aruba do
  let(:described_class) { Rounders::Commands::GlobalCommand }
  let(:described_instance) { described_class.new(arguments) }

  describe '#version' do
    before(:each) { run('rounders version') }
    it { expect(last_command_started).to be_successfully_executed }
    it { expect(last_command_started).to have_output(Rounders::VERSION.to_s) }
  end
end
