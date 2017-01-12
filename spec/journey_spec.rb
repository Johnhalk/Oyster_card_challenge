require 'journey'

describe Journey do
  subject(:journey) {described_class.new}
  let(:entry_station){double :entry_station}
  let(:exit_station){double :exit_station}

  describe '#start' do
    it 'creates a start for a journey' do
      expect(journey).to respond_to(:start).with(1).argument
    end
  end

  describe '#finish' do
    it 'creates a finish for a journey' do
      expect(journey).to respond_to(:finish).with(1).argument
    end
  end

  describe '#complete?' do
    it 'check if complete' do
      expect(journey).to be_complete
    end
  end
end
