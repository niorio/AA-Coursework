require 'arrays'

  describe Array do
    describe '#my_uniq' do
      it 'deletes duplicates from an array' do
        expect([1, 2, 1, 3, 3].my_uniq).to eq([1,2,3])
      end

      it 'should handle different cases' do
        expect([3,4,4,6,7,3].my_uniq).to eq([3,4,6,7])
      end
    end

    describe '#two_sum' do
      it 'finds all pairs of positions where the elements at those positions sum to zero' do
        expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
      end
    end

  end

  describe '#my_transpose' do
    it 'transposes an array' do
     rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
    ]

    cols = [
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ]

    expect(my_transpose(rows)).to eq(cols)
    end
  end

  describe '#stock_picker' do
    it "returns an array" do
      expect(stock_picker([100,200,400,300])).to be_a(Array)
    end

    it "returns the indexes of the best pair to buy/sell" do
      expect(stock_picker([100,200,400,300])).to eq([0,2])
    end
  end
