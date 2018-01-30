require 'station'

describe Station do
  subject(:station) {described_class.new("Bank", 1)}

  it "has a name" do
    expect(subject.name).to eq "Bank"
  end

  it "has a zone" do
    expect(subject.zone).to eq 1
  end
end
