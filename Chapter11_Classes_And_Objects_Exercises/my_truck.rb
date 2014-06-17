require_relative 'vehicle'

class MyTruck < Vehicle
  attr_accessor :color 
  attr_reader :year

  NUM_DOORS = 2 
 
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0

    @@num_vehicles += 1 
  end

end

truck = MyTruck.new(2011, "Purple", "Ford")
truck.print_num_vehicles
