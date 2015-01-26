class Tile

  attr_accessor :revealed

  def initialize
    @revealed = false
    @bomb = false
  end



end

class Board

  def initialize
    @board = Array.new(9) { Array.new(9) }

    @board.each do |row|
      @board.each do |col|
        @board[row][col] = Tile.new
      end
    end
  end


  def display
    @board.each do |row|
      @board.each do |col|
         p "*" if @board[row][col].revealed == false
      end
    end
  end
end


a = Board.new
a.display
