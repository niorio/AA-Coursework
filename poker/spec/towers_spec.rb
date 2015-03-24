require "towers.rb"

describe Towers do

  let(:tower) { Towers.new}

  describe '#stacks' do
    it "keeps three arrays" do
      expect(tower.stacks.count).to eq(3)
    end

    it "starts with default stacks" do
      expect(tower.stacks).to eq([[3,2,1],[],[]])
    end
  end

  describe '#move' do
    it 'moves piece from one tower to another' do
      tower.move(0,1)
      expect(tower.stacks).to eq([[3,2],[1],[]])
    end

    it 'should not let you put a larger disk on top of a smaller disk' do
      #expect(tower).to receive(:stacks).and_return([[3,2],[1],[]])
      tower.move(0,1)
      expect(tower.move(0,1)).to eq(false)
    end
  end

  describe '#gameover?' do
    it "it returns true if disks are moved to another col successfully" do
      expect(tower).to receive(:stacks).and_return([[],[3,2,1],[]])
      expect(tower.gameover?).to eq(true)
    end

    it "returns false if no winning conditions met" do
      expect(tower.gameover?).to eq(false)
    end
  end

  describe '#parse' do
    it "takes a string and returns an array of 2 numbers" do
      expect(tower.parse("1,2")).to eq([1,2])
    end
  end



end
