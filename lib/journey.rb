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
      if self.complete?
        return calculate_fare
      else
        return PENALTY
      end
    else
      0
    end
  end

  def calculate_fare
    arr_of_zones = []
    arr_of_zones << @details[:entry_station].zone
    arr_of_zones << @details[:exit_station].zone
    pounds = arr_of_zones.sort.reverse.inject(:-) + MINIMUM_FARE
    return pounds
  end

  def complete?
    @details[:entry_station] != nil && @details[:exit_station] != nil
  end

end
