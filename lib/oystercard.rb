require_relative 'journey'
require_relative 'station'

class Oystercard
attr_reader :balance
attr_accessor :journeys, :current_journey, :journey

MAX_LIMIT = 90
MIN_LIMIT = 1

  def initialize
    @balance = 0
    @in_journey = false
    @journeys = []
    @journey
  end

  def top_up(money)
    top_up_attempt = @balance + money
    message = "Limit of #{MAX_LIMIT} exceeded, can not top up the card."
    raise message if top_up_attempt > MAX_LIMIT
    @balance += money
  end

  def in_journey?
    @journey.journey_log[:entry_station] != nil && @journey.journey_log[:exit_station] == nil
  end

  def touch_in(entry_station)
    message = "Insufficient funds. Must top up card."
    raise message if balance < MIN_LIMIT
    @journey = Journey.new
    @journey.start(entry_station)
  end

  def touch_out(exit_station, fare)
    deduct(fare)
    if @journey == nil
      @journey = Journey.new
      @journey.start
    end
    @journey.finish(exit_station)
    journey_printer
  end

  def journey_printer
    @journeys << @journey.journey_log
    @journey = nil
  end

  private
  def deduct(money)
    @balance -= money
  end
end
