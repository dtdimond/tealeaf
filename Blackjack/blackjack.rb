# initialize the deck with num_decks number of decks
# shuffles the deck as well
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

# Display what each player is showing
def display_hands(players_hand, dealers_hand, is_show_all)
  puts "You have a #{get_score(players_hand)} "
  players_hand.each do |card|
    puts "#{card[:value]} of #{card[:suit]}"
  end

  puts "\nDealer is showing a #{get_score(dealers_hand)} "
  dealers_hand.each_with_index do |card, index|
    #first card is face down unless dealer's turn
    if index != 0 || is_show_all 
      puts "#{card[:value]} of #{card[:suit]}"
    end
  end

  puts "\n\n"
end
  
# Returns the value of the hand
def get_score(hand)
  score = 0

  hand.each do |card|
    val = card[:value]
    case val
    when 2..9
      score += val
    when 10..13
      score += 10
    when 1
      score + 11 <= 21 ? score += 11 : score += 1
    end

    return score if score > 21
  end

  return score
end

# Checks if the passed in hand has busted
# Returns true or false
def is_bust(hand)
  return get_score(hand) > 21 ? true : false
end


# Player loop - repeatedly ask to hit/stay until stay or bust
#   loops using recursion for fun
def do_player_hit_stay(is_stay, players_hand, dealers_hand, deck)
  if is_stay
    return
  else
    display_hands(players_hand, dealers_hand, false)
    puts "Enter 'stay' to stay or 'hit' to receive another card."
    is_stay = gets.chomp == "hit" ? false : true
    
    if(!is_stay)
      deal_card(players_hand, deck)
      
      #Check if we've won or lost on hit
      if get_score(players_hand) > 21
        puts "Bust! You lose"
        display_hands(players_hand, dealers_hand, true)
        return false
      elsif get_score(players_hand) == 21
        puts "Blackjack! You win!"
        display_hands(players_hand, dealers_hand, true)
        return true
      else #if not, loop back
        do_player_hit_stay(is_stay, players_hand, dealers_hand, deck)
      end
    end
  end
end

# Dealer
def do_dealer_hit_stay(is_stay, players_hand, dealers_hand, deck)
  if is_stay
    return
  else
    display_hands(players_hand, dealers_hand, true)

    sleep(5) #let player register the info

    #Dealer must hit if below 16
    if get_score(dealers_hand) < 16
      deal_card(dealers_hand, deck)
      
      #Check if dealer wins/loses on this hit
      if get_score(dealers_hand) == 21
        puts "Dealer blackjack! Dealer wins"
        display_hands(players_hand, dealers_hand)
        return false
      elsif get_score(dealers_hand) > 21
        puts "Dealer bust! You win"
        display_hands(players_hand, dealers_hand)
        return true
      else #if not, loop back
        do_dealer_hit_stay(false, players_hand, dealers_hand, deck)
      end
    else
       puts "Dealer stays with a #{get_score(dealers_hand)}"
    end
  end
end

def get_if_player_wins(players_hand, dealers_hand)
  is_player_a_winner = false
  
  if get_score(players_hand) > get_score(dealers_hand)
    puts "You win with a #{get_score(players_hand)}. Dealer had #{get_score(dealers_hand)}"
    is_player_a_winner = true
  elsif get_score(players_hand) < get_score(dealers_hand)
    puts "You lose. You had #{get_score(players_hand)}. Dealer had #{get_score(dealers_hand)}"
  else
     puts "Dealer wins the push! You had #{get_score(players_hand)}. Dealer had #{get_score(dealers_hand)}"
  end

  display_hands(players_hand, dealers_hand, true)
  return is_player_a_winner
end

# Main game entry point 
def start_game
  puts "Let's play some blackjack"

  #game state variables
  deck = []
  players_hand = []
  dealers_hand = []

  #deal deck and hands
  init_deck(4, deck)
  deal_new_hand(players_hand, dealers_hand, deck)

  # Do loops to hit/stay for player and then for dealer
  # Each fn will return true if the player won from a 
  # blackjack/dealer bust. Otherwise go to showdown.
  if do_player_hit_stay(false, players_hand, dealers_hand, deck)
    return true
  elsif do_dealer_hit_stay(false, players_hand, dealers_hand, deck)
    return true
  else
    return get_if_player_wins(players_hand, dealers_hand)
  end

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
