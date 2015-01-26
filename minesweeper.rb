require 'byebug'
require 'yaml'

class Array

  def valid?
    self.all? { |coord| coord.between?(0,8) }
  end

end

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

  def initialize(bomb, coordinate, board)
    @revealed = false
    @bomb = bomb
    @coordinate = coordinate
    @flagged = false
    @board = board
  end

  def show
    if @flagged
      "F"
    elsif !@revealed
      "*"
    else
      if @bomb
        "B"
      else
        neighbor_bomb_count == 0 ? "_" : neighbor_bomb_count
      end
    end

  end

  def neighbor_bomb_count

    x, y = @coordinate

    bomb_count = 0

    NEIGHBORS.each do |(xd, yd)|

      new_position = [ (xd + x), (yd + y) ]

      if new_position.valid?
        (bomb_count += 1) if @board[new_position].bomb
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

      new_position = [ (xd + x), (yd + y) ]

      result << @board[new_position] if new_position.valid?

    end

    result

  end

end

class Board

  attr_reader :board

  def initialize

    @board = Array.new(9) { Array.new(9) }

    bomb_array = generate_bombs

    @board.each_with_index do |row, x|
      row.each_index do |y|
        row[y] = Tile.new(bomb_array.shift, [x,y], self)
      end
    end

  end

  def [](pos)
    row, col = pos[0], pos[1]
    @board[row][col]
  end

  def display

    @board.each do |row|
      row.each do |el|
        print el.show + " "
      end
      puts
    end

    puts

  end

  def bomb_display
    @board.each do |row|
      row.each do |el|
        print "* " if !el.bomb
        print "B " if el.bomb
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

class Minesweeper

  def initialize
    @board = Board.new
    @time = Time.now
  end

  def play

    puts "\nTimer: #{(Time.now - @time).round}"
    puts "THIS IS THE USER DISPLAY"
    @board.display
    puts "THIS IS THE BOMB DISPLAY"
    @board.bomb_display

    lose = false

    while !win? && !lose
      puts "If you would like to save, enter S"
      puts "If you wish to place a flag, enter F."
      puts "To enter coordinates, hit enter then enter coordinate"
      action = gets.chomp.upcase

      if action == "F"
        tile = @board[user_input]
        tile.flagged = ! tile.flagged
      elsif action == "S"
        Minesweeper.save_game(self)
      else
        tile = @board[user_input]
        tile.reveal unless tile.flagged
        lose = true if tile.bomb unless tile.flagged
        puts "\nYou selected a tile that has been flagged.  No action was taken!" if tile.flagged
        #  else
        #    puts "Invalid input"
      end

      puts "\nTimer: #{(Time.now - @time).round}"
      @board.display
    end

    puts "You Win!" if win?

    puts "YOU LOSE!" if lose

  end


  def win?

    revealed_tile_count = 0

    @board.board.each_with_index do |row, x|
      row.each_index do |y|
        revealed_tile_count += 1 if row[y].revealed
      end
    end

    return true if revealed_tile_count == 71

    false

  end

  def user_input

    puts "Enter your row."
    row = gets.chomp.to_i

    puts "Enter your column."
    column = gets.chomp.to_i

    while ![row,column].valid?
      puts "Invalid Input - try again."
      row, column = user_input
    end

    [row, column]
  end


  def self.load_game(file_name)
    game_yaml = File.read(file_name)
    YAML.load(game_yaml)
  end

  def self.save_game(game)
    title = Time.now.to_s# + ".txt"
    File.open(title, "w") do |f|
      f.puts game.to_yaml
    end
  end

end

if __FILE__ == $PROGRAM_NAME

  if ARGV[0]
    game = Minesweeper.load_game(ARGV[0])
    ARGV.shift
  else
    game = Minesweeper.new
  end

  game.play

end
