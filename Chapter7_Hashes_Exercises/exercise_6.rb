words = ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live', 'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide', 'flow', 'neon'] 

anagrams = {}

words.each do |word|
  sorted_word = word.chars.sort.join

  if anagrams.has_key?(sorted_word)
    anagrams[sorted_word].push(word)
  else
    anagrams[sorted_word] = [word]
  end
end

anagrams.each do |key, val|
  p val
end




