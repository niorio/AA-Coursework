

class Card
  attr_reader :suit, :name, :point_value
  SUIT = [:hearts, :diamonds, :clubs, :spades]
  POINTS = {:two => 2,
            :three => 3,
            :four => 4,
            :five => 5,
            :six => 6,
            :seven => 7,
            :eight => 8,
            :nine => 9,
            :ten => 10,
            :jack => 11,
            :queen => 12,
            :king => 13,
            :ace => 14}

  def initialize(suit, name)
    @suit = suit
    @name = name
    @point_value = POINTS[name]
  end

  def self.suits
    SUIT
  end

  def self.names
    POINTS.keys
  end


end
