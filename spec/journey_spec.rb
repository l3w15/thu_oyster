require 'journey'

describe Journey do

  let(:card) { double("an oystercard", balance: 90) }
  subject(:journey) { described_class.new }
  describe "#start" do
    it "changes the in_journey status" do
      subject.start
      expect(subject).to be_in_journey
    end
  end

  describe "#finish" do
    it "changes the in_journey status" do
      subject.start
      subject.finish
      expect(subject).not_to be_in_journey
    end

    it "calculates the fare" do
      subject.start
      subject.finish
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end
  end
end
