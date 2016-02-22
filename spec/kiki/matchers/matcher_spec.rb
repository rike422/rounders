require 'spec_helper'

describe Kiki::Matchers::Matcher do
  let(:described_class) { Kiki::Matchers::Matcher }
  let(:described_instance) { described_class.build(arguments) }
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
      expect(matcher.matchers).to include(a_kind_of(Kiki::Matchers::To))
      expect(matcher.matchers).to include(a_kind_of(Kiki::Matchers::Subject))
    end
    context 'When matcher is not implemented' do
      it 'should raise MatcherNoImplementError' do
        expect { described_class.build(but_matcher: 'but!') }.to raise_error(Kiki::Matchers::NoImplementError)
      end
    end
  end

  describe '#match' do
    let(:message) do
      Kiki::Mail.new(
        Mail.new(
          from: 'rike422@github.com',
          subject: 'subject1'
        )
      )
    end
    let(:arguments) do
      {
        from: /rike422/,
        subject: /subject/
      }
    end
    let(:matcher) do
      described_class.build(arguments)
    end
    context 'when all matcher are match' do
      it 'return MatchData' do
        expect(described_instance.match(message)).to match(
          from: a_collection_containing_exactly(
            a_kind_of(MatchData)),
          subject: a_kind_of(MatchData)
        )
      end
    end
    context 'when include miss match pattern' do
      let(:arguments) do
        {
          from: /missMatchFrom/,
          subject: /missMatch/
        }
      end
      it 'return nil' do
        expect(described_instance.match(message)).to be_nil
      end
    end
  end
end
