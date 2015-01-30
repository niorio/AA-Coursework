require 'hand'

describe Hand do
  let(:hand) {Hand.new}

  describe '#cards' do
    it 'should start as an empty array' do
      expect(hand.cards).to eq([])
    end
  end

  describe '#take' do
    it 'should take cards from the deck' do
      cards = [Card.new(:hearts, :two), Card.new(:spades, :ace)]
      hand.take(cards)
      expect(hand.cards).to eq(cards)
    end
  end

  describe '#flush?' do
    it 'should return true if hand has a flush' do
      hand = Hand.new([Card.new(:spades, :four),
                      Card.new(:spades, :six),
                      Card.new(:spades, :eight),
                      Card.new(:spades, :ten),
                      Card.new(:spades, :two)])
      expect(hand.flush?).to be_truthy
    end
  end

  describe '#straight?' do
    it 'should return true if hand has a straight' do
      hand = Hand.new([Card.new(:hearts, :four),
                      Card.new(:spades, :six),
                      Card.new(:spades, :five),
                      Card.new(:spades, :seven),
                      Card.new(:spades, :eight)])

      expect(hand.straight?).to be_truthy
    end
  end

  describe '#straight_flush?' do
    it 'should return true if hand has a straight flush' do
      hand = Hand.new([Card.new(:spades, :four),
                      Card.new(:spades, :six),
                      Card.new(:spades, :five),
                      Card.new(:spades, :seven),
                      Card.new(:spades, :eight)])

      expect(hand.straight_flush?).to be_truthy
    end
  end

  describe '#four_of_a_kind?' do
    it 'should return true if hand has four of a kind' do
      hand = Hand.new([Card.new(:spades, :four),
                      Card.new(:hearts, :four),
                      Card.new(:spades, :five),
                      Card.new(:diamonds, :four),
                      Card.new(:spades, :four)])
      expect(hand.four_of_a_kind?).to be_truthy
    end
  end

  describe '#three_of_a_kind?' do
    it 'should return true if hand has four of a kind' do
      hand = Hand.new([Card.new(:spades, :four),
                      Card.new(:hearts, :four),
                      Card.new(:spades, :five),
                      Card.new(:diamonds, :seven),
                      Card.new(:spades, :four)])
      expect(hand.three_of_a_kind?).to be_truthy
    end
  end

  describe '#pair?' do
    it 'should return true if hand has four of a kind' do
      hand = Hand.new([Card.new(:spades, :four),
                      Card.new(:hearts, :four),
                      Card.new(:spades, :five),
                      Card.new(:diamonds, :seven),
                      Card.new(:spades, :nine)])
      expect(hand.pair?).to be_truthy
    end
  end

  describe 'full_house?' do
    it 'should return true if hand has full house' do
      hand = Hand.new([Card.new(:spades, :four),
                      Card.new(:hearts, :four),
                      Card.new(:spades, :five),
                      Card.new(:diamonds, :four),
                      Card.new(:spades, :five)])

      expect(hand.full_house?).to be_truthy
    end
  end

  describe 'two_pair?' do
    it 'should return true if hand has two_pair' do
      hand = Hand.new([Card.new(:spades, :four),
                      Card.new(:hearts, :four),
                      Card.new(:spades, :five),
                      Card.new(:diamonds, :eight),
                      Card.new(:spades, :five)])
       expect(hand.two_pair?).to be_truthy
    end
  end



end
