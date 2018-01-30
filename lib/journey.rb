class Journey

  MINIMUM_FARE = 1

  def initialize
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def start
    change_in_journey_status
  end

  def finish
    change_in_journey_status
  end

  def fare
    MINIMUM_FARE
  end

  private

  def change_in_journey_status
    @in_journey = !@in_journey
  end

end
