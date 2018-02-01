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
    fail "You need at least £#{MINIMUM_FARE} to travel" unless able_to_travel?
    # if !@history.empty? then
    #   @history[-1].check_for_penalty
    #   if @history[-1].details[:penalty] == true then
    #     @balance -= PENALTY
    #     @history[-1].details[:penalty] = false
    #   end
    # end
    if !@history.empty? then
      deduct(@history[-1].fare)
    end
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
    @journey.check_for_penalty
    change_in_journey_status
    deduct(@journey.fare)
    # @journey.details[:penalty] = false
    @history << @journey
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

  def deduct(amount)
    @balance -= amount
  end

  def change_in_journey_status
    @in_journey = !@in_journey
  end

end
