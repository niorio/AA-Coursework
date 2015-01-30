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
end
