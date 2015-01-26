class Tile

  attr_accessor :revealed, :flagged
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
    @flagged = false
  end

  def show
    if @flagged
      return "F"

    elsif !@revealed
      return "*"

    else
      if @bomb
        return "B"
      else
        neighbor_bomb_count == 0 ? "_" : neighbor_bomb_count
      end
    end


  end

  def neighbor_bomb_count
    x, y = @coordinate

    bomb_count = 0

    NEIGHBORS.each do |(xd, yd)|

      new_position = [xd + x, yd + y]

      if new_position.all? { |coord| coord.between?(0,8)}
        bomb_count += 1 if @board[new_position].bomb
      end

    end

    bomb_count

  end

  def reveal
    @revealed = true

    return if neighbor_bomb_count > 0

    neighbors.each do |neighbor|

      neighbor.reveal if ! neighbor.revealed

    end

  end

  def neighbors

    x, y = @coordinate

    result = []

    NEIGHBORS.each do |(xd, yd)|

      new_position = [xd + x, yd+ y]

      if new_position.all? { |coord| coord.between?(0,8)}
        result << @board[new_position]
      end

    end

    result

  end

  def get_board(board)
    @board = board
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

    @board.each_with_index do |row, x|
      row.each_index do |y|
        @board[x][y].get_board(self)
      end
    end

    #play

  end

  def play

    puts "THIS IS THE USER DISPLAY"
    display
    puts "THIS IS THE BOMB DISPLAY"
    bomb_display

    lose = false

    while !win? && !lose
      puts "If you wish to place a flag, enter F.  If not, hit enter, then enter your coordinate."
      action = gets.chomp.upcase

      if action == "F"
        tile = self[user_input]
        tile.flagged = ! tile.flagged
      else
        tile = self[user_input]
        tile.reveal unless tile.flagged
        lose = true if tile.bomb unless tile.flagged
        puts "\nYou selected a tile that has been flagged.  No action was taken!" if tile.flagged
    #  else
    #    puts "Invalid input"
      end

      display
    end

    puts "You Win!" if win?

    puts "YOU LOSE!" if lose

  end

  def win?

    revealed_tile_count = 0

    @board.each_with_index do |row, x|
      row.each_index do |y|
        revealed_tile_count += 1 if row[y].revealed
      end
    end

    p revealed_tile_count

    return true if revealed_tile_count == 71

    false

  end

  def user_input

    bomb_display
    puts "Enter your row."
    row = gets.chomp.to_i

    while !row.between?(0,8) || !row.is_a?(Integer)
      puts "Invalid Input - try again."
      puts
      user_input
    end


    puts "Enter your column."
    column = gets.chomp.to_i

    while !column.between?(0,8) || !row.is_a?(Integer)
      puts "Invalid Input - try again."
      puts
      user_input
    end

    [row, column]
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
