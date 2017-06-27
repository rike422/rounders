require 'spec_helper'

describe Rounders::Commands::LocalCommand do
  let(:described_class) { Rounders::Commands::LocalCommand }
  let(:described_instance) { described_class.new(*arguments) }
  let(:arguments) { [] }

  describe '#start' do
    it 'should support dotenv option' do
      double = instance_double(Rounders::Rounder)
      expect(double).to receive(:start)
      expect(Rounders::Rounder).to receive(:new).with('dotenv': true, 'deamon': false).and_return(double)
      Rounders::Commands::LocalCommand.start(%w[start --dotenv])
    end
    it 'should support deamon option' do
      double = instance_double(Rounders::Rounder)
      expect(double).to receive(:start)
      expect(Rounders::Rounder).to receive(:new).with('dotenv': false, 'deamon': true).and_return(double)
      Rounders::Commands::LocalCommand.start(%w[start --deamon])
    end
    it 'should support pidFile option' do
      double = instance_double(Rounders::Rounder)
      expect(double).to receive(:start)
      expect(Rounders::Rounder).to receive(:new).with('dotenv': false, 'deamon': false, 'pid': './tmp/rounders.pid').and_return(double)
      Rounders::Commands::LocalCommand.start(%w[start --pid ./tmp/rounders.pid])
    end
  end
end
