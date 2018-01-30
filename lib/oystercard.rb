class Oystercard
  attr_reader :balance
  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Limit of #{LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "You need at least £#{MINIMUM_FARE} to travel" unless able_to_travel?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
  end

  private

  def limit_reached?(amount)
    balance + amount > LIMIT
  end

  def able_to_travel?
    balance > MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end

end
