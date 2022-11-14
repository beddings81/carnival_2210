class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :total_revenue,
              :rider_log

  def initialize(attributes)
    @name = attributes[:name]
    @min_height = attributes[:min_height]
    @admission_fee = attributes[:admission_fee]
    @excitement = attributes[:excitement]
    @total_revenue = 0
    @rider_log = {}
  end
  
  def board_rider(visitor)
    # require 'pry'; binding.pry
    if visitor.preferences.include?(@excitement) && visitor.height >= @min_height 
      if @rider_log[visitor].nil?
        rider_log[visitor] = 1
        visitor.spending_money - @admission_fee
        @total_revenue += @admission_fee
      else
        rider_log[visitor] += 1
        visitor.spending_money - @admission_fee
        @total_revenue += @admission_fee
      end
      # require 'pry'; binding.pry
    end
  end


end
