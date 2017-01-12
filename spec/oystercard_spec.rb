require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:entry_station){double :entry_station}
  let(:exit_station){double :exit_station}

  describe '#balance' do
    it 'checks that the oystercard has a balance' do
      expect(card).to respond_to(:balance)
    end
    it 'has an initial balance' do
      expect(card.balance).to eql 0
    end
  end

  describe '#top_up' do
    it 'allows card to be topped up by a certain amount' do
      expect(card).to respond_to(:top_up).with(1).argument
    end
    it 'the oystercard will accept a value and store it' do
      expect{card.top_up Oystercard::MIN_LIMIT}.to change {card.balance }.by (Oystercard::MIN_LIMIT)
    end
      it 'will raise an error if top up limit is exceeded' do
        card.top_up(Oystercard::MAX_LIMIT)
        expect{card.top_up(Oystercard::MIN_LIMIT)}.to raise_error("Limit of #{Oystercard::MAX_LIMIT} exceeded, can not top up the card.")
    end
  end

  describe '#touch_in' do
    context 'when card has balance' do
      before(:each) do
        card.top_up(Oystercard::MAX_LIMIT)
        card.touch_in(entry_station)
      end
      it 'can touch in' do
        expect(card.in_journey?).to eq(true)#be_in_journey
      end
      it 'expect entry station to be recorded' do
        expect(card.journey.journey_log).to include(:entry_station)
      end
    end

    context 'when card has no balance' do
      it 'raises error if not enough balance' do
        message = "Insufficient funds. Must top up card."
        expect{card.touch_in(entry_station)}.to raise_error(message)
      end
    end
  end

  describe '#touch_out' do
    before(:each) do
      card.top_up(Oystercard::MIN_LIMIT)
      card.touch_in(entry_station)
    end

    it 'can touch out' do
      card.touch_out(exit_station, Oystercard::MIN_LIMIT)
      expect(card).not_to be_in_journey
    end
    it 'to be charged when we touch out of our journey' do

      expect{card.touch_out(exit_station,Oystercard::MIN_LIMIT)}.to change{card.balance}.by (-Oystercard::MIN_LIMIT)
    end
  end

  describe 'touching in and touching out edge cases' do
    before(:each) do
      card.top_up(Oystercard::MAX_LIMIT)
    end
    it 'touching in without touching out' do
      2.times do
        card.touch_in(entry_station)
      end
      expect(card.journeys.length).to eq 1
    end
    it 'touching out without touching in' do
      card.touch_out(exit_station)
      expect(card.entry_station).to eq nil
    end
  end

  describe '#journey_printer' do

    before(:each) do
      card.top_up(Oystercard::MAX_LIMIT)
      card.touch_in(:entry_station)
      card.touch_out(:exit_station, Oystercard::MIN_LIMIT)
    end
    it 'prints a list of all journeys' do
      expect(card.journey.journey_log).to include(:entry_station, :exit_station)
    end
  end

end
