require './lib/visitor'
require './lib/ride'

RSpec.describe Ride do 
  let!(:ride1) {Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })}
  let!(:ride2) {Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })}
  let!(:ride3) {Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })}
  let!(:visitor1) {Visitor.new('Bruce', 54, '$10')}
  let!(:visitor2) {Visitor.new('Tucker', 36, '$5')}
  let!(:visitor3) {Visitor.new('Penny', 64, '$15')}

  it 'exist and has attributes' do
    expect(ride1).to be_a(Ride)
    expect(ride1.name).to eq("Carousel")
    expect(ride1.min_height).to eq(24)
    expect(ride1.admission_fee).to eq(1)
    expect(ride1.excitement).to eq(:gentle)
    expect(ride1.total_revenue).to eq(0)
  end

  it 'can board riders and keep a log' do
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)

    expect(ride1.rider_log).to eq({})

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)

    expect(ride1.rider_log).to eq({visitor1 => 2, visitor2 => 1})
    expect(ride1.total_revenue).to eq(3)
    expect(ride1.ride_count).to eq(3)
  end

  it 'can take money from a visitor' do
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor3.add_preference(:thrilling)

    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)
    ride3.board_rider(visitor1)
    ride3.board_rider(visitor2)
    ride3.board_rider(visitor3)

    expect(visitor1.spending_money).to eq(8)
    expect(visitor2.spending_money).to eq(4)
    expect(visitor3.spending_money).to eq(13)
  end

  it 'can board riders if they are tall enough or they have a matching preference' do
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:thrilling)

    ride3.board_rider(visitor1)
    ride3.board_rider(visitor2)
    ride3.board_rider(visitor3)

    expect(ride3.rider_log).to eq({visitor3 => 1})
    expect(ride3.total_revenue).to eq(2)
  end

  it 'can calculate its total revenue' do
    visitor3.add_preference(:thrilling)

    ride3.board_rider(visitor3)
    ride3.board_rider(visitor3)
    ride3.board_rider(visitor3)
    ride3.board_rider(visitor3)

    expect(ride3.total_revenue).to eq(8)
  end

end
