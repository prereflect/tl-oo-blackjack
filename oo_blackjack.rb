class Deck
  SUITS = %w(Hearts Diamonds Clubs Spades)
  VALUES = %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King)
  attr_accessor :deck
 
  def initialize  
    cards = []
    SUITS.each do |suit|
      VALUES.each do |value|
        cards << "#{ value } of #{ suit }"
      end
    end

    deck = {}
    cards.each do |card|
      case
      when card[0] == "2"
        deck.store(card, 2)
      when card[0] == "3"
        deck.store(card, 3)
      when card[0] == "4"
        deck.store(card, 4)
      when card[0] == "5"
        deck.store(card, 5)
      when card[0] == "6"
        deck.store(card, 6)
      when card[0] == "7"
        deck.store(card, 7)
      when card[0] == "8"
        deck.store(card, 8)
      when card[0] == "9"
        deck.store(card, 9)
      when card[0] == "1"
        deck.store(card, 10)
      when card[0] == "J"
        deck.store(card, 10)
      when card[0] == "Q"
        deck.store(card, 10)
      when card[0] == "K"
        deck.store(card, 10)
      when card[0] == "A"
        deck.store(card, 11)
      end
    end

    @deck = deck
  end
  
  def shuffle_deck!
    self.deck = Hash[deck.to_a.shuffle!]
  end

  def initial_cards(player, dealer)
    player << deal
    dealer << deal
    player << deal
    dealer << deal
  end

  def deal
    deck.shift
  end
end

module Hand
  def hit(card)
    hand << card
  end

  def total
    if over_21? && total_with_ace?
      fix_ace_over_21
    else
      hand.to_h.values.reduce(:+)
    end
  end
  
  def show_cards
    puts "#{ name }\'s cards: #{ cards } Total: #{ total }"
  end

  private

  def cards
    hand.to_h.keys.join(", ")
  end

  def over_21?
    hand.to_h.values.reduce(:+) > 21
  end

  def total_with_ace?
    hand.to_h.values.include?(11)
  end

  def fix_ace_over_21
    total = hand.to_h.values
    amount_of_aces = total.count(11)
    total.delete(11)
    amount_of_aces.times { total << 1 }
    amount_of_aces.times do
      if total.reduce(:+) <= 11
        total << 10
      else
        total << 0
      end
    end
    total.reduce(:+)
  end
end

class Player
  include Hand
  attr_reader :name
  attr_accessor :hand
  
  def initialize
    @name = "Player"
    @hand = []
  end
end

class Dealer
  include Hand
  attr_reader :name
  attr_accessor :hand
  
  def initialize
    @name = "Dealer"
    @hand = []
  end
end

class Blackjack
  BLACKJACK = 21
  DEALER_STAY = 17
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end
  
  def initial_blackjack?
    player.show_cards
    dealer.show_cards
    puts

    case
    when player.total == BLACKJACK && dealer.total == BLACKJACK
      puts "Push! #{ player.name } & #{ dealer.name } both have Blackjack"
      play_again?
    
    when player.total == BLACKJACK
      puts "Blackjack! #{ player.name } wins"
      play_again?
    
    when dealer.total == BLACKJACK
      puts "Blackjack! #{ dealer.name } wins"
      play_again?
    end
  end

  def player_turn
    system "clear"

    loop do
      player.show_cards
    
      begin
        puts
        puts "#{ player.name }, would you like to Hit or Stay? [h/s]"
        input = gets.chomp.downcase
      end until ['h', 's'].include?(input)
    
      if input == "h"
        player.hit(deck.deal)
        player_game_over?
        system "clear"
      else
        break
      end
    end
  end

  def player_game_over?
    system "clear"
    player.show_cards
    dealer.show_cards
    puts
    
    case
    when player.total == 21
      puts "21! #{ player.name }, You win!"
      play_again?

    when player.total > 21
      puts "#{ player.name }, You Busted. #{ dealer.name } wins"
      play_again?
    end
  end
  
  def dealer_turn
    system "clear"
    player.show_cards
    dealer.show_cards

    while dealer.total < DEALER_STAY
      dealer.hit(deck.deal)
      puts
      puts "Dealer hits..."
      dealer.show_cards
      dealer_game_over?
    end
  end

  def dealer_game_over?
    case
    when dealer.total == 21
      puts
      puts "21! #{ dealer.name } wins"
      play_again?

    when dealer.total > 21
      puts
      puts "#{ dealer.name } Busted. #{ player.name } wins!"
      play_again?
    end
  end

  def compare_hands
    case
    when player.total > dealer.total
      puts
      puts "#{ player.name } wins!"
      play_again?

    when dealer.total > player.total
      puts
      puts "#{ dealer.name } wins"
      play_again?

    when player.total ==  dealer.total
      puts
      puts "It\'s a Push! No winner"
      play_again?
    end
  end

  def play_again?
    begin
      puts
      puts "Play again? [y/n]"
      play_again = gets.chomp.downcase
    end until ["y", "n"].include?(play_again)

    if play_again == "y"
      Blackjack.new.play
    else
      system "clear"
      puts "Thanks for playing!"
      exit
    end
  end

  def play
    system "clear"
    deck.shuffle_deck!
    deck.initial_cards(player.hand, dealer.hand)
    initial_blackjack?
    player_turn
    dealer_turn
    compare_hands
  end
end

Blackjack.new.play

