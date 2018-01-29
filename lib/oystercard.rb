class Oystercard
  attr_reader :balance
  LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Limit of #{LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  private

  def limit_reached?(amount)
    @balance + amount > LIMIT
  end

end
