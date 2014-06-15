puts "Type a number between 0 and 100"

num = gets.to_i

if num > 0 && num < 50
  puts "Number is between 0 and 50"
elsif num < 100
  puts "Number is between 50 and 100"
else
  puts "Number is over 100"
end

