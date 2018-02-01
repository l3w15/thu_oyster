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
    @journey = nil
  end

  def top_up(amount)
    fail "Limit of #{LIMIT} exceeded" if limit_reached?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    journey_starter_checks
    journey_starter(entry_station)
  end

  def touch_out(exit_station)
    journey_finisher_check
    journey_finisher(exit_station)
  end

  private

  def journey_starter_checks
    fail "You need at least £#{MINIMUM_FARE} to travel" unless able_to_travel?
    deduct(@history[-1].fare) if !@history.empty?
  end

  def journey_starter(entry_station)
    @history << @journey = Journey.new
    @journey.start(entry_station)
  end

  def journey_finisher_check
    @history << @journey = Journey.new if @journey == nil
  end

  def journey_finisher(exit_station)
    @journey.finish(exit_station)
    deduct(@journey.fare)
    @journey.details[:paid] = true
    @journey = nil
  end

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
