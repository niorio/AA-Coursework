require 'deck'

describe Deck do

  let(:deck) {Deck.new}

  describe '#cards' do
    it "should contain 52 cards" do
      expect(deck.cards.count).to eq(52)
    end

    it "should not contain any duplicates" do
      expect(deck.cards).to eq(deck.cards.uniq)
    end
  end

  describe '#shuffle' do
    it 'should return a randomly shuffled deck' do
      deck.shuffle
      expect(deck.cards).not_to eq(Deck.all_cards)
    end
  end

  describe '#deal' do
    it 'should remove cards from the deck' do
      deck.deal(5)
      expect(deck.cards.count).to eq(47)
    end

    it 'should return an array of cards' do
      cards = deck.deal(5)
      expect(cards[0]).to be_a(Card)
    end
  end

  describe '#return' do
    it 'should return cards to the bottom of the deck' do
      cards = [Card.new(:spades, :three), Card.new(:clubs, :four)]
      deck.return(cards)
      expect(deck.cards[-2..-1]).to eq(cards)
    end
  end
end
