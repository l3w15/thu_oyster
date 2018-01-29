require 'oystercard'

describe Oystercard do

  context "when created" do
    it "has a balance of 0" do
      expect(subject.balance).to eq 0
    end
  end

end
