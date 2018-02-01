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

  def touch_in(entry_station)
    if @journeys.last.complete? == false
      deduct(penalty_fare)
    end
    fail "You need at least £#{MINIMUM_FARE} to travel" unless able_to_travel?

    journey = Journey.new

    journey.start(entry_station)
    change_in_journey_status
  end

  def touch_out(exit_station)
    journey.complete? ? deduct(MINIMUM_FARE) : deduct(penalty_fare)

    journey.finish(exit_station)
    change_in_journey_status
    @journeys << journey
  end

  def in_journey?
    @in_journey
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
