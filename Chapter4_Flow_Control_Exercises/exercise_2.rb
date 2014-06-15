def to_cap(word)
  if word.length > 10
    puts word.upcase
  else
    puts word
  end
end

to_cap("Test")
to_cap("thisIsAMuchlongerTEST")
