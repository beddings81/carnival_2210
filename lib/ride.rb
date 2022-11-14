class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :rider_log

  attr_accessor :total_revenue, :ride_count           

  def initialize(attributes)
    @name = attributes[:name]
    @min_height = attributes[:min_height]
    @admission_fee = attributes[:admission_fee]
    @excitement = attributes[:excitement]
    @total_revenue = 0
    @rider_log = {}
    @ride_count = 0
  end
  
  def board_rider(visitor)
    return unless visitor.preferences.include?(@excitement) && visitor.height >= @min_height 
    if @rider_log[visitor].nil?
      rider_log[visitor] = 1
      visitor.spending_money -= @admission_fee
      @total_revenue += @admission_fee
      @ride_count += 1
    else
      rider_log[visitor] += 1
      visitor.spending_money -= @admission_fee
      @total_revenue += @admission_fee
      @ride_count += 1
    end
  end
end
