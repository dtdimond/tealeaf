car = {make: "Chevy", model: "Prism"}

car.each_key { |key| puts key }
car.each_value { |val| puts val }

car.each { |key, val| puts "This #{key} is the key and #{val} is the value" }
