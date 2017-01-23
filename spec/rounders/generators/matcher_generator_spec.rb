require 'spec_helper'

describe Rounders::Generators::MatcherGenerator do
  let(:described_class) { Rounders::Generators::MatcherGenerator }
  let(:described_instance) { described_class.new(arguments) }
  let(:arguments) do
    { name: name }
  end
  let(:name) { 'my_matcher' }
end
