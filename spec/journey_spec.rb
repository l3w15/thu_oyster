require 'journey'

describe Journey do

  let(:card) { double("an oystercard", balance: 90) }
  subject(:journey) { described_class.new }
  let(:station) { double("for a stion", zone: 1) }
  let(:another_station) { double("for a stion", zone: 4) }

  describe "#start" do
    it "stores the entry_station" do
      subject.start(station)
      expect(subject.details[:entry_station]).to eq station
    end
  end

  describe "#finish" do
    it "stores the exit_station" do
      subject.start(station)
      subject.finish(another_station)
      expect(subject.details[:exit_station]).to eq another_station
    end
  #
  #   it "calculates the fare" do
  #     subject.start
  #     subject.finish
  #     expect(subject.fare).to eq Journey::MINIMUM_FARE
  #   end
  end

  describe "#details" do
    it "shows the journey details" do
      subject.start(station)
      subject.finish(another_station)
      expect(journey.details).to eq({entry_station: station, exit_station: another_station, paid: false})
    end
  end

  describe "#journey_complete?" do
    it "returns true if card has touched in and out" do
      subject.start(station)
      subject.finish(another_station)
      expect(subject.complete?).to eq true
    end

    # returns false if forgotten to touch in or out for that journey
  end

  describe "#fare" do
    it "returns the correct sume to deduct" do
      subject.start(station)
      expect(subject.fare).to eq 6
    end
  end

  describe "#calculate_fare" do
    it "calculates the fare" do
      subject.start(station)
      subject.finish(another_station)
      allow(station).to receive(:zone) { 1 }
      allow(another_station).to receive(:zone) { 4 }
      expect(subject.fare).to eq 4
    end
  end

end
