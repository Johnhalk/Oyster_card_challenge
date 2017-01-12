class Oystercard
attr_reader :balance, :entry_station, :exit_station
attr_accessor :journeys, :current_journey

MAX_LIMIT = 90
MIN_LIMIT = 1

  def initialize
    @balance = 0
    @in_journey = false
    @journeys = []
  end

  def top_up(money)
    top_up_attempt = @balance + money
    message = "Limit of #{MAX_LIMIT} exceeded, can not top up the card."
    raise message if top_up_attempt > MAX_LIMIT
    @balance += money
  end

  def in_journey?
    if entry_station == nil
      @in_journey = false
    else
      @in_journey = true
    end
  end

  def touch_in(entry_station)
    message = "Insufficient funds. Must top up card."
    raise message if balance < MIN_LIMIT
    @in_journey = true
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_LIMIT)
    @exit_station = exit_station
    @in_journey = false
    journey_log
  end

  def journey_log
    current_journey = Hash.new
    current_journey[:entry_station] = @entry_station
    current_journey[:exit_station] = @exit_station
    @journeys << current_journey
  end

  private
  def deduct(money)
    @balance -= money
  end
end
