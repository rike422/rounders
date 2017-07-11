require 'spec_helper'

describe Rounders::Commands::GlobalCommand, type: :aruba do
  let(:described_class) { Rounders::Commands::GlobalCommand }
  let(:described_instance) { described_class.new(arguments) }
  let(:name) { 'test_app' }
  let(:work_dir) { 'tmp/aruba' }
  describe 'rounders new' do
    before do
      described_class.start(%W[new #{name} #{work_dir}])
    end

    after do
      FileUtils.rm_rf File.join(work_dir, name)
    end

    describe 'File' do
      before(:each) do
        cd name
      end

      it 'should generate project configure files' do
        expect(file?('Gemfile')).to be true
        expect(file?('Rakefile')).to be true
        expect(file?('MIT-LICENSE')).to be true
        expect(file?('README.md')).to be true
        expect(file?('.gitignore')).to be true
      end

      describe 'config' do
        it 'should generate application configure files' do
          expect(exist?('config')).to be true
          expect(exist?('config/application.rb')).to be true
          expect(exist?('config/initializers/mail.rb')).to be true
        end
      end

      describe 'app' do
        it 'should generate application' do
          expect(exist?('app')).to be true
        end
      end
    end
  end
end
