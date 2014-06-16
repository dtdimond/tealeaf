deck = []

def initDeck(numDecks, deck)
  suits = ["diamonds","clubs","spades","hearts"]
  values = [1,2,3,4,5,6,7,8,9,10,11,12,13]

  suits.each do |suit|
    values.each do |val|
      numDecks.times { deck.push({suit: suit, value: val}) }
    end
  end

  deck.shuffle!
end

initDeck(1, deck)
p deck
puts deck.length
