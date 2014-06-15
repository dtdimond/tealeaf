def find_in(word)
  if /lab/ =~ word
    puts word
  else
    puts "Not found"
  end
end

find_in("laboratory")
find_in("experiment")
find_in("Pans Labyrinth")
find_in("elaborate")
find_in("polar bear")
