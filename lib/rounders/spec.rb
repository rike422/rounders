RSpec.configure do |config|
  config.before(:each) do
    Topping.build
  end
end
