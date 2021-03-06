# RSpec matcher to spec delegations.
# Forked from https://gist.github.com/ssimeonov/5942729 with fixes
# for arity + custom prefix.
#
# Usage:
#
#     describe Post do
#       it { is_expected.to delegate(:name).to(:author).with_prefix } # post.author_name
#       it { is_expected.to delegate(:name).to(:author).with_prefix(:any) } # post.any_name
#       it { is_expected.to delegate(:month).to(:created_at) }
#       it { is_expected.to delegate(:year).to(:created_at) }
#       it { is_expected.to delegate(:something).to(:'@instance_var') }
#     end

RSpec::Matchers.define :delegate do |method|
  match do |delegator|
    @method = @prefix ? :"#{@prefix}_#{method}" : method
    @delegator = delegator

    if @to.to_s[0] == '@'
      # Delegation to an instance variable
      old_value = @delegator.instance_variable_get(@to)
      begin
        @delegator.instance_variable_set(@to, receiver_double(method))
        @delegator.send(@method) == :called
      ensure
        @delegator.instance_variable_set(@to, old_value)
      end
    elsif @delegator.respond_to?(@to, true)
      unless [0, -1].include?(@delegator.method(@to).arity)
        raise "#{@delegator}'s' #{@to} method does not have zero or -1 arity (it expects parameters)"
      end
      allow(@delegator).to receive(@to).and_return(receiver_double(method))
      @delegator.send(@method) == :called
    else
      raise "#{@delegator} does not respond to #{@to}"
    end
  end

  description do
    "delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end

  failure_message do
    "expected #{@delegator} to delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end

  failure_message_when_negated do
    "expected #{@delegator} not to delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end

  chain(:to) { |receiver| @to = receiver }
  chain(:with_prefix) { |prefix = nil| @prefix = prefix || @to }

  def receiver_double(method)
    double('receiver').tap do |receiver|
      allow(receiver).to receive(method).and_return(:called)
    end
  end
end
