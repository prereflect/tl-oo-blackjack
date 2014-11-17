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
      when card[0] == "A"
        deck.store(card, 11)
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
      end
    end
  
    @deck = deck
  end
  
  def shuffle
    self.deck = Hash[deck.to_a.shuffle!]
  end
end

class Hand
  def initialize
  end
end

class Player
  def initialize
  end
end

class Dealer
  def initialize
  end
end

class Blackjack
  attr_accessor :deck, :hand, :player, :dealer

  def initialize
    @deck = Deck.new
    @hand = Hand.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def play
    deck.shuffle

  end
end

Blackjack.new.play

