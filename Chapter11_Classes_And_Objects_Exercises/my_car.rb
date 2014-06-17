require_relative 'vehicle'

class MyCar < Vehicle
  attr_accessor :color 
  attr_reader :year

 
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def spray_paint(color)
    self.color = color
  end

  def to_s
    puts "Your car is a #{@year} #{@model} in good looking #{@color} travelling #{@speed} miles per hour."
  end

end


car = MyCar.new(2001, "Green", "Prism")

car.speed_up(10)
car.current_speed

puts car.color
car.color = "Blue"
puts car.color
puts car.year

car.spray_paint("Red")
puts car.color

MyCar.gas_mileage(12, 500)

puts car


# In excercise 3, that error occurs because the code is trying to set the value of a readable only (not setter function) attribute. You could fix it by not doing that, or by changing 'attr_reader' to 'attr_accessor'
