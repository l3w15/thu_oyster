class Oystercard
  attr_reader :balance, :entry_station
  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Limit of #{LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  def in_journey?
    !!entry_station 
  end

  def touch_in(station)
    fail "You need at least £#{MINIMUM_FARE} to travel" unless able_to_travel?
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
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
