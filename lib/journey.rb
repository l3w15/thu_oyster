class Journey

  MINIMUM_FARE = 1
  PENALTY = 6
  attr_reader :details

  def initialize
    @details = {entry_station: nil, exit_station: nil, penalty: nil}
  end

  def start(station)
    @details[:entry_station] = station
  end

  def finish(station)
    @details[:exit_station] = station
    fare
  end

  def check_for_penalty
    @details[:penalty] = true if !self.complete?
  end

  def fare
    if @details[:penalty] == true then
      @details[:penalty] == false 
      PENALTY
    else
      MINIMUM_FARE
    end
  end

  def complete?
    @details[:entry_station] != nil && @details[:exit_station] != nil
  end

end
