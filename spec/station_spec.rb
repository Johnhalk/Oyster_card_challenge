require 'station'

describe Station do
  subject(:station) {described_class.new("Bank", 1)}

  it 'tells us what zone we are in' do
    expect(station.zone).to eq(1)
  end
  it 'tells us what the name of the station we are in' do
    expect(station.name).to eq("Bank")
  end

end
