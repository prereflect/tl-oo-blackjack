require "pry"

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
    player << deal << deal
    dealer << deal << deal
  end

  def deal
    deck.shift
  end
end

module Hand
  def show_cards
    puts "#{ name }\'s cards: #{ hand.to_h.keys.join(", ") } Total: #{ total }"
  end

  def hit(card)
    hand << card
  end

  def total
    hand.to_h.values.reduce(:+)
  end
end

class Player
  include Hand
  attr_reader :name
  attr_accessor :hand
  
  def initialize(name)
    @name = name
    @hand = []
  end
end

class Dealer
  include Hand
  attr_reader :name
  attr_accessor :hand
  
  def initialize(name)
    @name = name
    @hand = []
  end
end

class Blackjack
  BLACKJACK = 21
  DEALER_STAY = 17
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new("Toby")
    @dealer = Dealer.new("Dealer")
  end
  
  def initial_blackjack?
    if player.total == BLACKJACK && dealer.total == BLACKJACK
      player.show_cards
      dealer.show_cards
      puts
      puts "Push! #{ player.name } & #{ dealer.name } both have Blackjack"
    
    elsif player.total == BLACKJACK
      player.show_cards
      dealer.show_cards
      puts
      puts "Blackjack! #{ player.name } wins"
    
    elsif dealer.total == BLACKJACK
      player.show_cards
      dealer.show_cards
      puts
      puts "Blackjack! #{ dealer.name } wins"
    end
  end

  def player_hit
    loop do
      player.show_cards
   
      begin
        puts
        puts "#{ player.name }, would you like to Hit or Stay? [h/s]"
        input = gets.chomp.downcase
      end until ['h', 's'].include?(input)
   
      if input == "h"
        player.hit(deck.deal)
        system "clear"
      else
        break
      end
    end
  end

  def dealer_hit
    system "clear"
    dealer.show_cards
    
    while dealer.total < DEALER_STAY
      dealer.hit(deck.deal)
      puts
      puts "Dealer hits..."
      dealer.show_cards
    end
  end
  
  def play
    system "clear"
    deck.shuffle_deck!
    deck.initial_cards(player.hand, dealer.hand)
    initial_blackjack?
    player_hit   
    dealer_hit 
  end
end

Blackjack.new.play

