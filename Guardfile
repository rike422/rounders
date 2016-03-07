group :red_green_refactor, halt_on_fail: true do
  guard :rubocop, all_on_start: false, cli: ['--format', 'clang', '-D'] do
    watch(/.+\.rb$/)
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end

  guard :rspec, cmd: 'bundle exec rspec --color --format documentation' do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb') { 'spec' }
  end
end
