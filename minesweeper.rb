class Tile

  attr_accessor :revealed
  attr_reader :bomb

  NEIGHBORS = [
    [-1,-1],
    [0,-1],
    [1,-1],
    [-1,0],
    [1,0],
    [-1,1],
    [0,1],
    [1,1]
  ]

  def initialize(bomb, coordinate)
    @revealed = false
    @bomb = bomb
    @coordinate = coordinate
  end

  def show
    if ! @revealed
      return "*"
      #blank
      #with flag
    else
      if @bomb
        return "B"
      else
        return "_"
      end
      #bomb_neighbor_count
    end
  end

  def neighbor_bomb_count(board)
    x, y = @coordinate

    bomb_count = 0

    NEIGHBORS.each do |(xd, yd)|

      new_position = [xd + x, yd+ y]

      if new_position.all? { |coord| coord.between?(0,8)}
        ##valid neighbors
        bomb_count += 1 if board[new_position].bomb
      end

    end

    bomb_count

  end

  def reveal
    @revealed = true
  end

end

class Board

  attr_reader :board

  def initialize
    @board = Array.new(9) { Array.new(9) }

    bomb_array = generate_bombs

    @board.each_with_index do |row, x|
      row.each_index do |y|
        row[y] = Tile.new(bomb_array.shift, [x,y])
      end
    end

    puts "THIS IS THE USER DISPLAY"
    display
    puts "THIS IS THE BOMB DISPLAY"
    bomb_display



  end

  def [](pos)
    x, y = pos[0], pos[1]
    @board[x][y]
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


#a = Board.new
#a.display
