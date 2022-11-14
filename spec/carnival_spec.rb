require './lib/visitor'
require './lib/ride'
require './lib/carnival'

RSpec.describe Carnival do
  let!(:carnival) {Carnival.new("3 Days")}
  let!(:ride1) {Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })}
  let!(:ride2) {Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })}
  let!(:ride3) {Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })}
  let!(:visitor1) {Visitor.new('Bruce', 54, '$10')}
  let!(:visitor2) {Visitor.new('Tucker', 36, '$5')}
  let!(:visitor3) {Visitor.new('Penny', 64, '$15')}

  it 'exist and has a duration' do
    expect(carnival).to be_a(Carnival)
    expect(carnival.duration).to eq("3 Days")
    expect(carnival.rides).to eq([])
  end

  it 'can add rides' do
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    expect(carnival.rides).to eq([ride1, ride2, ride3])
  end

  it 'can find its most popular ride' do
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:thrilling)

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor1)
    ride3.board_rider(visitor3)
    ride3.board_rider(visitor3)
    ride3.board_rider(visitor3)

    expect(carnival.most_popular_ride).to eq(ride3)
  end

  it 'can return its most profitable ride' do
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:thrilling)

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)
    ride3.board_rider(visitor3)
    ride3.board_rider(visitor3)
    ride3.board_rider(visitor3)

    expect(ride1.total_revenue).to eq(3)
    expect(ride3.total_revenue).to eq(6)
    expect(carnival.most_profitable_ride).to eq(ride3)
  end

  it 'can calculate the total revenue' do
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:thrilling)

    ride2.board_rider(visitor1)
    ride2.board_rider(visitor2)
    ride2.board_rider(visitor1)
    ride3.board_rider(visitor3)
    ride3.board_rider(visitor3)
    ride3.board_rider(visitor3)

    expect(carnival.total_revenue).to eq(21)
  end

  xit 'can provide a summary hash' do
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:thrilling)

    ride2.board_rider(visitor1)
    ride2.board_rider(visitor2)
    ride2.board_rider(visitor1)
    ride3.board_rider(visitor3)
    ride3.board_rider(visitor3)
    ride3.board_rider(visitor3)

    expect(carnival.summary_hash).to eq({:a => 1})
  end
end
