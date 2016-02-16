require 'spec_helper'

describe Kiki::Matchers::Matcher do
  let(:described_class) { Kiki::Matchers::Matcher }
  let(:described_instance) { described_class.new(arguments) }
  let(:arguments) do
    {
      to: ['rike422@github.co.jp'],
      subject: /test mail/
    }
  end

  describe '.new' do
    subject { described_instance }
    it { is_expected.to be_a described_class }
  end

  describe '.build' do
    let(:matcher) do
      described_class.build(arguments)
    end
    it 'should return Matcher class instance' do
      expect(matcher).to be_a(Kiki::Matchers::Matcher)
    end
    it 'should be able to find and create a matcher instance' do
      expect(matcher.send(@matchers)).to include(a_kind_of(Kiki::Matchers::CC))
      expect(matcher.send(@matchers)).to include(a_kind_of(Kiki::Matchers::Subject))
    end
    context 'When matcher is not implemented' do
      it 'should raise MatcherNoImplementError' do
        expect { described_class.build(but_matcher: 'but!') }.to raise_error(Kiki::Matcher::NoImplimentError)
      end
    end
  end

  describe '#match' do
    let(:matcher) do
      described_class.build(arguments)
    end
    context 'when all matcher are match' do
      before do
        allow_any_instance_of(Kiki::Matcher::CC).to receive(:match?).and_return(
          domain: 'gmail.com'
        )
        allow_any_instance_of(Kiki::Matcher::From).to receive(:match?).and_return(
          domain: 'yahoo.com'
        )
      end
      it 'return true' do
        expect(described_incetane.match(message)).to be_eql(
          cc: [
            { domain: 'gmail.com' }
          ],
          from: [
            { domain: 'yahoo.com' }
          ]
        )
      end
    end
    context 'when include miss match pattern' do
      before do
        allow_any_instance_of(Kiki::Matcher::CC).to receive(:match?).and_return(true)
        allow_any_instance_of(Kiki::Matcher::From).to receive(:match?).and_return(false)
      end
      it 'return false' do
        expect(described_incetane.match?(message)).to Hash.empty
      end
    end
  end
end
