class Carnival
  attr_reader :duration,
              :rides

  attr_accessor :summary

  def initialize(duration)
    @duration = duration
    @rides = []
    @summary = Hash.new
  end

  def add_ride(ride)
    @rides.push(ride)
  end

  def most_popular_ride
    @rides.max do |ride|
      ride.ride_count
    end
  end

  def most_profitable_ride
    @rides.max do |ride|
      ride.total_revenue
    end
  end

  def total_revenue
    @rides.sum do |ride|
      ride.total_revenue
    end
  end

  # def summary_hash
  #   #visitor count
  #   #revenue earned
  #   #List of visitors and each visitor's favorite ride and how much total money a visitor spent
  #   #List of rides and who rode each ride and the ride's total revenue
  #   @rides.each do |ride|
  #     ride.rider_log do |visitor, times|
  #       @summary[visitor] = 3
  #       @summary[revenue] = total_revenue 
  #     end
  #   end
  #   @summary
  # end
end         