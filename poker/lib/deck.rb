class Deck
  attr_reader :cards

  def initialize
    @cards = Deck.all_cards
  end

  def shuffle
    @cards.shuffle
  end


  private

  def self.all_cards
    all_cards=[]
    Card.suits.each do |suit|
      Card.names.each do |name|
          all_cards << Card.new(suit, name)
      end
    end
    all_cards
  end

end
