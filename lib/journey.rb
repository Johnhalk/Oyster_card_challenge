class Journey
attr_reader :journey_log

  def initialize
    @journey_log = {}
    @entry_station
    @exit_station
  end

  def start(entry_station = nil)
    @entry_station = entry_station
    @journey_log[:entry_station] = @entry_station
  end

  def finish(exit_station = nil)
    @journey_log[:exit_station] = exit_station
  end

  def complete?
    entry_station = @journey_log[entry_station]
    exit_station =  @journey_log[exit_station]
    !!(entry_station and exit_station)
   end
 end
end
