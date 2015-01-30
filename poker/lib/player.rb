class Player
  attr_reader :hand, :pot

  def initialize
    @pot = 2000
    @hand = Hand.new
  end

  def get_hand(deck)
    hand.take(deck.deal(5))
  end



end
