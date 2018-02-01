require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  let(:station) { double("for a stion", zone: 1) }
  let(:another_station) { double("for a stion", zone: 4) }

  context "when created" do
    it "has a balance of 0" do
      expect(subject.balance).to eq 0
    end
  end


  context "when card is fully topped up" do

    before(:each) do
      subject.top_up(Oystercard::LIMIT)
    end

    describe '#top_up' do

      it 'raises an error if top up causes balance to exceed limit' do
        # allow(subject).to receive(:balance).and_return(90) <--returns 90 but @balance is still zero
        expect { subject.top_up(1) }.to raise_error "Limit of #{Oystercard::LIMIT} exceeded"
      end
    end

    describe '#touch_in' do

      it "sets the entry station" do
        subject.touch_in(station)
        expect(subject.history.last.details[:entry_station]).to eq station
      end

      it "charges unpaid penalties" do
        subject.touch_in(station)
        expect { subject.touch_in(station) }.to change { subject.balance }.by (-Oystercard::PENALTY)
      end
    end

    describe '#touch_out' do

      it "sets the exit station" do
        subject.touch_in(station)
        subject.touch_out(another_station)
        expect(subject.history.last.details[:exit_station]).to eq another_station
      end

      it "deducts the penalty fare if not touched in" do
        expect { subject.touch_out(station) }.to change { subject.balance }.by (-Oystercard::PENALTY)
      end

    end

    describe "#history" do
      it "returns a journey history" do
        subject.touch_in(station)
        subject.touch_out(another_station)
        expect(subject.history.last.details).to eq({entry_station: station, exit_station: another_station, paid: true })
      end
    end
  end

  context "when card is not fully topped up" do
    describe '#top_up' do
      it 'adds money to the balance' do
        expect { subject.top_up 10 }.to change { subject.balance }.by 10
      end
    end

    describe '#touch_in' do
      it 'raises an error if balance is less than minimum amount' do
        expect { subject.touch_in(station) }.to raise_error "You need at least £#{Oystercard::MINIMUM_FARE} to travel"
      end
    end

  end
end
