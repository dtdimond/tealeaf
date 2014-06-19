require_relative 'vehicle'

module Offroadable
  def offroad
    "The vehicle is now offroading"
  end
end


class MyTruck < Vehicle
  include Offroadable

  NUM_DOORS = 2 
 
end

truck = MyTruck.new(2011, "Purple", "Ford")
truck.print_num_vehicles

puts MyTruck.ancestors
