require 'byebug'
require_relative 'card.rb'

class Hand
  attr_reader :cards, :hand_value

  def initialize(cards = [])
    @cards = cards
  end

  def take(new_cards)
    @cards += new_cards
  end
  #
  # def winner(*opponent_values)
  #   opponent_values.push
  #   possible_winner = []
  #   max_hand = 0
  #   opponent_values.each do |hand_values|
  #     possible_winner << hand_values if hand_values[0] >= max_hand
  #   end
  #   #
  #   # return true if @hand_value[0] > opponent_value[0]
  #   # return false if @hand_value[0] < opponent_value[0]
  #   #
  #   # return true if @hand_value[1] > opponent_value[1]
  #   # false
  #
  # end

  def hand_value
    @hand_value = []
    if straight_flush?
      @hand_value << 9 << straight_flush?
    elsif four_of_a_kind?
      @hand_value << 8 << four_of_a_kind?
    elsif full_house?
      @hand_value << 7 << full_house?
    elsif flush?
      @hand_value << 6 << flush?
    elsif straight?
      @hand_value << 5 << straight?
    elsif three_of_a_kind?
      @hand_value << 4 << three_of_a_kind?
    elsif two_pair?
      @hand_value << 3 << two_pair?
    elsif pair?
      @hand_value << 2 << pair?
    else
      @hand_value << 1 << points[0]
    end

  end





  def kinds
    kind = Hash.new{|h,k| h[k] = 0}

    cards.each do |card|
      kind[card.name] += 1
    end

    kind
  end

  def points
    points = []
    @cards.each do |card|
      points << card.point_value
    end
    points.sort.reverse
  end


  def suits
    suits = Hash.new{|h,k| h[k] = 0}

    cards.each do |card|
      suits[card.suit] += 1
    end

    suits
  end

  def flush?
    if suits.value?(5)
      points[0]
    else
      false
    end
  end

  def straight?
    points.each_index do |i|
      next if i == (points.count - 1)
      return false unless (points[i] - points[i+1]) == 1
    end
    points[0]
  end

  def straight_flush?
    if straight? && flush?
      points[0]
    else
      false
    end
  end

  def four_of_a_kind?
    if kinds.value?(4)
      Card::POINTS[kinds.key(4)]
    else
      false
    end
  end


  def three_of_a_kind?
    if kinds.value?(3)
      Card::POINTS[kinds.key(3)]
    else
      false
    end
  end

  def pair?
    if kinds.value?(2)
      Card::POINTS[kinds.key(2)]
    else
      false
    end
  end

  def full_house?
    if pair? && three_of_a_kind?
      three_of_a_kind?
    else
      false
    end
  end

  def two_pair?
    pairs = 0
    set = []
    kinds.each do |card,count|
      if count == 2
        pairs += 1
        set << Card::POINTS[card]
      end
    end
    if pairs == 2
      set.max
    else
      false
    end
  end

end
