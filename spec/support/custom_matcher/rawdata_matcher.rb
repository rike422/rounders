RSpec::Matchers.define :eq_attachments do |expected|
  match do |actual|
    actual.encoding == Encoding::BINARY &&
      actual == expected.dup.force_encoding(Encoding::BINARY)
  end
end
