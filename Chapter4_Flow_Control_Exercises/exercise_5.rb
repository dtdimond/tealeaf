puts "Type a number between 0 and 100"
num = gets.to_i

def original_method(num)
  if num < 0 
    return puts "No negatives"
  elsif num < 50
    puts "Number is between 0 and 50"
  elsif num < 100
    puts "Number is between 50 and 100"
  else
    puts "Number is over 100"
  end
end

def case_method(num)
  case
  when num < 0
    puts "No negatives"
  when num < 50
    puts "Number is between 0 and 50"
  when num < 100
    puts "Number is between 50 and 100"
  else
    puts "Number is above 100"
  end
end


original_method(num)
case_method(num)
