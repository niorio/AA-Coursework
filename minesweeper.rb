class Tile

  attr_accessor :revealed
  attr_reader :bomb

  def initialize(bomb)
    @revealed = false
    @bomb = bomb
    #@value
  end

  def show
    if ! @reveealed
      return "*"
      #blank
      #with flag
    else
      return "B" if bomb
      #bomb_neighbor_count
    end
  end

  def neighbor_bomb_count(board)
    

  end

  def reveal
    @revealed = true
  end

end

class Board

  def initialize
    @board = Array.new(9) { Array.new(9) }

    bomb_array = generate_bombs

    @board.each do |row|
      row.each_index do |i|
        row[i] = Tile.new(bomb_array.shift)
      end
    end



    puts "THIS IS THE USER DISPLAY"
    display
    puts "THIS IS THE BOMB DISPLAY"
    bomb_display

  end

  def display

    puts

    @board.each do |row|
      row.each do |el|
        print el.show
      end
      puts
    end

    puts

  end

  def bomb_display
    @board.each do |row|
      row.each do |el|
        print "*" if !el.bomb
        print "B" if el.bomb
      end
      puts
    end

    puts
  end

  def generate_bombs
    bombs = []
    71.times {bombs << false}
    10.times {bombs << true}
    bombs.shuffle
  end

end


a = Board.new
#a.display
