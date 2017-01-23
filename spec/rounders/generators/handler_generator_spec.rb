require 'spec_helper'

describe Rounders::Generators::HandlerGenerator do
  let(:described_class) { Rounders::Generators::HandlerGenerator }
  let(:described_instance) { described_class.new(arguments) }
  let(:arguments) do
    { name: name }
  end
  let(:name) { 'my_handler' }
end
