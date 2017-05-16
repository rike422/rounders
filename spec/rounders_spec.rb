require 'spec_helper'

describe Rounders do
  it 'has a version number' do
    expect(Rounders::VERSION).not_to be nil
  end

  describe '.global?' do
    context 'when app directory not exists' do
      before do
        allow_any_instance_of(Pathname).to receive(:exist?).and_return(false)
      end
      it 'should return false' do
        expect(Rounders.global?).to be_falsey
      end
    end
    context 'when app directory exists' do
      before do
        allow_any_instance_of(Pathname).to receive(:exist?).and_return(true)
      end
      it 'should return true' do
        expect(Rounders.global?).to be_truthy
      end
    end
  end
end
