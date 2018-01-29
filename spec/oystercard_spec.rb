require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  context "when created" do
    it "has a balance of 0" do
      expect(subject.balance).to eq 0
    end
    it "is not in journey" do
      expect(subject).not_to be_in_journey
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

    describe '#deduct' do
      it 'subtracts money from the balance' do
        expect { subject.deduct 10 }.to change { subject.balance }.by -10
      end
    end

    describe '#touch_in' do
      it "changes 'in_journey' attribute from false to true" do
        expect { subject.touch_in }.to change { subject.in_journey? }.from(false).to true
      end
    end

    describe '#touch_out' do
      it "changes 'in_journey' attribute from true to false" do
        subject.touch_in
        expect { subject.touch_out }.to change { subject.in_journey? }.from(true).to false
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
        expect { subject.touch_in }.to raise_error "You need at least £#{Oystercard::MINIMUM_TRAVEL_BALANCE} to travel"
      end
    end

  end
end
