class Journey

  MINIMUM_FARE = 1
  PENALTY = 6
  attr_reader :details

  def initialize
    @details = {entry_station: nil, exit_station: nil, paid: false}
    # have paid not penalty
  end

  def start(station)
    @details[:entry_station] = station
  end

  def finish(station)
    @details[:exit_station] = station
    fare
  end

  def fare
    if @details[:paid] == false then
      self.complete? ? calculate_fare : PENALTY
    else
      0
    end
  end

  def calculate_fare
    arr_of_zones = [@details[:entry_station].zone, @details[:exit_station].zone]
    arr_of_zones.sort.reverse.inject(:-) + MINIMUM_FARE
  end

  def complete?
    @details[:entry_station] != nil && @details[:exit_station] != nil
  end

end
