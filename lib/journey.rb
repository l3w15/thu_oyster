class Journey

  MINIMUM_FARE = 1
  PENALTY = 6
  attr_reader :details

  def initialize
    @details = {entry_station: nil, exit_station: nil}
  end

  def start(station)
    @details[:entry_station] = station
  end

  def finish(station)
    @details[:exit_station] = station
    fare
  end

  def fare
    if self.complete? == true then
      MINIMUM_FARE
    else
      PENALTY
    end
  end

  def complete?
    @details[:entry_station] != nil && @details[:exit_station]
  end

end
