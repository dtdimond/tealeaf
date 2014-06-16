def init_deck(num_decks, deck)
  suits = ["diamonds","clubs","spades","hearts"]
  values = [1,2,3,4,5,6,7,8,9,10,11,12,13]
  deck.clear #shouldn't need this, but just in case

  suits.each do |suit|
    values.each do |val|
      num_decks.times { deck.push({suit: suit, value: val}) }
    end
  end

  deck.shuffle!
end

# deal out a card if there are any left in deck. 
# else grab one new deck and then deal a card.
def deal_card(hand, deck)
  if deck.empty?
    init_deck(1, deck)
  end

  hand.push(deck.pop)
end

def display_hands(players_hand, dealers_hand)
  puts "\nYou have: "
  players_hand.each do |card|
    puts "#{card[:value]} of #{card[:suit]}"
  end

  puts "\nDealer is showing: "
  dealers_hand.each_with_index do |card, index|
    if index != 0 #first card is face down
      puts "#{card[:value]} of #{card[:suit]}"
    end
  end
end
  

#Recursive function - Asks the player if they want to hit
def do_player_hit_stay(is_stay, players_hand, dealers_hand, deck)
  if is_stay
    return
  else
    display_hands(players_hand, dealers_hand)
    puts "Enter 'stay' to stay or 'hit' to receive another card."
    is_stay = gets.chomp == "hit" ? false : true
    
    if(!is_stay && players_hand.size < 7)
      deal_card(players_hand, deck)
      do_player_hit_stay(is_stay, players_hand, dealers_hand, deck)
    end
  end
end

def start_game
  puts "Let's play some blackjack"

  #game state variables
  deck = []
  players_hand = []
  dealers_hand = []

  #deal deck and hands
  init_deck(4, deck)
  deal_new_hand(players_hand, dealers_hand, deck)
  do_player_hit_stay(false, players_hand, dealers_hand, deck)

  #draw_stay_dealer(dealers_hand)

end

def clear_hands(hands)
  hands.each { |hand| hand.clear }
end

#deals out a new hand to both players.
#clears both players' hands first.
def deal_new_hand(players_hand, dealers_hand, deck)
  hands = [players_hand, dealers_hand]

  clear_hands(hands)

  2.times do
    hands.each do |hand|
      deal_card(hand, deck)
    end
  end
end  


  
start_game
