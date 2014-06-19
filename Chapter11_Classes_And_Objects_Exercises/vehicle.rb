class Vehicle
  @@num_vehicles = 0
  attr_accessor :color
  attr_reader :model, :year

  def initialize(y, m ,c)
    @@num_vehicles += 1
    @year = y
    @model = m
    @color = c
    @speed = 0
  end

  def print_num_vehicles
    puts "Num outstanding vehicles: #{@@num_vehicles}"
  end

  def self.gas_mileage(gas, miles)
    puts "Your car gets #{miles/gas} gallons to the mile"
  end
  
  def speed_up(speed)
    @speed += speed
  end

  def brake(speed)
    @speed -= speed
  end

  def shut_off
    @speed = 0
  end

  def current_speed
    puts "You are going #{@speed}"
  end

  def print_age
    puts "The vehicle is #{years_old} years old."
  end

  private

  def years_old
    Time.now.year - self.year
  end
end

