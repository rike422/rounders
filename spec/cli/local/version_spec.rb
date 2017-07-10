require 'spec_helper'

describe Rounders::Commands::LocalCommand, type: :aruba do
  describe '#version' do
    before(:each) { run('rounders version') }
    it { expect(last_command_started).to be_successfully_executed }
    it { expect(last_command_started).to have_output(Rounders::VERSION.to_s) }
  end
end
