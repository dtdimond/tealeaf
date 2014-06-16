# initialize the deck with num_decks number of decks
# shuffles the deck as well
def init_deck(num_decks, deck)
  suits = ["diamonds","clubs","spades","hearts"]
  values = ["Ace",2,3,4,5,6,7,8,9,10,"Jack","Queen","King"]
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
  #Players score/hand 
  puts "You have a #{get_score(players_hand)} "
  players_hand.each do |card|
    puts "#{card[:value]} of #{card[:suit]}"
  end

  #Display dealers score
  if is_show_all
    puts "\nDealer is showing a #{get_score(dealers_hand)} "
  else
    puts "\nDealer is showing a #{get_score_face_up(dealers_hand)} "
  end

  # Display dealers cards
  dealers_hand.each_with_index do |card, index|
    #first card is face down unless dealer's turn
    if index != 0 || is_show_all 
      puts "#{card[:value]} of #{card[:suit]}"
    end
  end

  puts "\n\n"
end
  
# Returns the value of the hand
# Credit to Prasanna Joshi for 
# inspiration on handling the aces
def get_score(hand)
  score = 0
  
  values = hand.map{|card| card[:value]}
  values.each do |val|
    if Array(2..10).include?(val)
      score += val
    elsif ["Jack", "Queen", "King"].include?(val)
      score += 10
    end
  end
  
  # deal with the aces
  values.count("Ace").times do
    if score + 11 <= 21
      score += 11
    else
      score += 1
    end
  end

  return score
end


# Returns the score of all the faceup cards. Only
# the first card is facedown for the dealer.
def get_score_face_up(hand)
  return get_score(hand[1..-1])
end

# Player loop - repeatedly ask to hit/stay until stay or bust
#   loops using recursion for fun
def do_player_hit_stay(is_stay, players_hand, dealers_hand, deck)
  if is_stay
    return
  else
    display_hands(players_hand, dealers_hand, false)
    if get_score(players_hand) == 21
        puts "Blackjack! You win!"
        return "win"
    end

    puts "Enter 'stay' to stay or 'hit' to receive another card."
    is_stay = gets.chomp == "hit" ? false : true
    
    if(!is_stay)
      deal_card(players_hand, deck)

      #Check if we've won or lost on hit
      if get_score(players_hand) > 21
        puts "Bust! You lose"
        display_hands(players_hand, dealers_hand, true)
        return "loss"
      elsif get_score(players_hand) == 21
        puts "Blackjack! You win!"
        display_hands(players_hand, dealers_hand, true)
        return "win"
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

    sleep(1.5) #let player register the info

    #Dealer must hit if below 17
    if get_score(dealers_hand) < 17
      deal_card(dealers_hand, deck)
      
      #Check if dealer wins/loses on this hit
      if get_score(dealers_hand) == 21
        puts "Dealer blackjack! Dealer wins"
        display_hands(players_hand, dealers_hand, true)
        return "loss"
      elsif get_score(dealers_hand) > 21
        puts "Dealer bust! You win"
        display_hands(players_hand, dealers_hand, true)
        return "win"
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
def start_game(name)
  puts "\n\n************************"
  puts "Let's play some blackjack, #{name}!\n\n"

  #game state variables
  deck = []
  players_hand = []
  dealers_hand = []

  #deal deck and hands
  init_deck(4, deck)
  deal_new_hand(players_hand, dealers_hand, deck)


  # Do loops to hit/stay for player and then for dealer
  # Fn will return true if the player won from a 
  # blackjack/dealer bust or false if player bust/dealer
  # blackjack. Otherwise go to showdown.

  result = do_player_hit_stay(false, players_hand, dealers_hand, deck)
  if result ==  "win"
    return true
  elsif result == "loss"
    return false
  end

  result = do_dealer_hit_stay(false, players_hand, dealers_hand, deck)
  if result == "win"
    return true
  elsif result == "loss"
    return false
  else
    return get_if_player_wins(players_hand, dealers_hand)
  end

end

#Empty hands
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




#Main loop
wins = 0
losses = 0
  
puts "Welcome to blackjack. What's your name?"
name = gets.chomp

while 1
  if start_game(name)
    wins += 1
    puts "Nice win!"
  else
    losses += 1
    puts "Better luck next time"
  end

  puts "You're now at #{wins} wins and #{losses} losses. Do you want to play again? Type 'yes' if so, or anything else to quit."
  break if gets.chomp != "yes"
end


