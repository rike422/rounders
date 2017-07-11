require 'spec_helper'

describe Rounders::Commands::GlobalCommand, type: :aruba do
  let(:described_class) { Rounders::Commands::GlobalCommand }
  let(:described_instance) { described_class.new(arguments) }
  let(:name) { 'test_plugin' }
  let(:plugin_name) { "rounders-#{name}" }
  let(:work_dir) { 'tmp/aruba/' }
  describe 'rounders plugin' do
    before do
      described_class.start(%W[plugin #{name} #{work_dir}])
    end

    after do
      FileUtils.rm_rf File.join(work_dir, plugin_name)
    end

    describe 'File' do
      before(:each) do
        cd plugin_name
      end

      it 'should generate project configure files' do
        expect(file?('Gemfile')).to be true
        expect(file?('Rakefile')).to be true
        expect(file?('MIT-LICENSE')).to be true
        expect(file?('README.md')).to be true
        expect(file?('.gitignore')).to be true
        expect(file?('rounders-test_plugin.gemspec')).to be true
      end

      describe 'lib' do
        it 'should generate application configure files' do
          dir = "lib/rounders/#{name}"
          expect(exist?('lib')).to be true
          expect(exist?("lib/rounders/#{name}.rb")).to be true
          expect(exist?("#{dir}/version.rb")).to be true
        end
      end
    end
  end
end
