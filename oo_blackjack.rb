class Deck
  def initialize
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
  def initialize
    @deck = Deck.new
    @hand = Hand.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def play
  end
end

Blackjack.new.play

