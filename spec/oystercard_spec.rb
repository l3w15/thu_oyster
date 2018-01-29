require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  context "when created" do
    it "has a balance of 0" do
      expect(subject.balance).to eq 0
    end
  end

  it { is_expected.to respond_to(:top_up).with(1).argument}

  describe '#top_up' do
    it 'adds money to the balance' do
      expect { subject.top_up 10 }.to change { subject.balance }.by 10
    end

    it 'raises an error if top up causes balance to exceed limit' do
      subject.top_up(Oystercard::LIMIT)
      # allow(subject).to receive(:balance).and_return(90) <--returns 90 but @balance is still zero
      expect { subject.top_up(1) }.to raise_error "Limit of #{Oystercard::LIMIT} exceeded"
    end
  end

end
