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
      subject.top_up(100)
      expect(subject.balance).to eq 100
    end
  end

end
