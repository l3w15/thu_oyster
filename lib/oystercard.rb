class Oystercard
  attr_reader :balance, :journeys
  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
    @in_journey = false
  end

  def top_up(amount)
    fail "Limit of #{LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in(entry_station)
    fail "You need at least £#{MINIMUM_FARE} to travel" unless able_to_travel?
    @journeys << {:entry_station => entry_station, :exit_station => nil}
    change_in_journey_status
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @journeys.last[:exit_station] = exit_station
    change_in_journey_status
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

  def change_in_journey_status
    @in_journey = !@in_journey
  end

end
