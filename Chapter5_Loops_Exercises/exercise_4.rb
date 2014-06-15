def countdown(num)
  if num > 0
    puts "t-minus: #{num}"
    num-=1
    countdown(num)
  end
end

countdown(10)
