class Tile

  attr_accessor :revealed

  def initialize
    @revealed = false
    @bomb = false
  end

end

class Board

  def initialize
    @board = Array.new(9) { Array.new(9) {"*"} }
  end

  #  @board.each do |row|
    #  9.times { @board[row] << Tile.new }
    #end

  #end


  def display

    @board.each do |row|
      row.each do |el|
        print el
      end
      puts
    end

  end

end


a = Board.new
a.display
