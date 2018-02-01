require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :history
  LIMIT = 90
  MINIMUM_FARE = 1
  PENALTY = 6

  def initialize
    @balance = 0
    @history = []
    @in_journey = false
    @journey = nil
  end

  def top_up(amount)
    fail "Limit of #{LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    # fail "You need at least £#{MINIMUM_FARE} to travel" unless able_to_travel?
    check_for_penalty
    @journey = Journey.new
    @history << @journey
    @journey.start(entry_station)
    change_in_journey_status
  end

  def touch_out(exit_station)
    if @journey == nil
      @journey = Journey.new
    end
    @journey.finish(exit_station)
    change_in_journey_status
    @history << @journey
    deduct(@journey.fare)
    @journey = nil
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

  def check_for_penalty
    if !@history.empty?
      p !@history.empty?
      p @history[-1]
      p !@history[-1].complete?
      if !@history[-1].complete?
        @balance -= PENALTY
      end
    end
  end

  def deduct(amount)
    @balance -= amount
  end

  def change_in_journey_status
    @in_journey = !@in_journey
  end

end
