class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys
  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
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
    @journeys << {:entry_station => @entry_station, :exit_station => nil}
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    @journeys.last[:exit_station] = @exit_station
    reset_stations
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

  def reset_stations
    @entry_station = nil
    @exit_station = nil
  end
end
