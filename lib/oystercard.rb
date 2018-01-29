class Oystercard
  attr_reader :balance
  LIMIT = 90
  MINIMUM_TRAVEL_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Limit of #{LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "You need at least £#{MINIMUM_TRAVEL_BALANCE} to travel" unless able_to_travel?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def limit_reached?(amount)
    @balance + amount > LIMIT
  end

  def able_to_travel?
    @balance > MINIMUM_TRAVEL_BALANCE
  end

end
