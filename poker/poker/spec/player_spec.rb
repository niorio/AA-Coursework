require 'player'

describe Player do
  let(:player) { Player.new }

  describe '#pot' do
    it 'has a numeric value' do
      expect(player.pot).to eq(2000)
    end
  end


end
