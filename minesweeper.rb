require 'yaml'

class Array
  def valid?
    self.all? { |coord| coord.between?(0,8) }
  end
end


class Tile

  attr_accessor :revealed, :flagged
  attr_reader :bomb

  ADJACENTS = [
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
        neighbor_bomb_count == 0 ? "_" : neighbor_bomb_count.to_s
      end
    end

  end

  def neighbor_bomb_count
    bomb_count = 0

    neighbors.each do |neighbor|
      bomb_count += 1 if neighbor.bomb
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

    ADJACENTS.each do |(dx, dy)|

      new_position = [ (x + dx), (y + dy) ]
      result << @board[new_position] if new_position.valid?

    end

    result

  end

end

class Board
  attr_reader :board

  def initialize
    @start_time = Time.now

    @board = Array.new(9) { Array.new(9) }

    bomb_distribution = generate_bombs

    @board.each_index do |r|
      @board[r].each_index do |c|
        @board[r][c] = Tile.new(bomb_distribution.shift, [r,c], self)
      end
    end

  end

  def [](pos)
    row, col = pos[0], pos[1]
    @board[row][col]
  end

  def display

    system('clear')
    puts "Timer: #{(Time.now - @start_time).round}\n\n"

    @board.each do |row|
      row.each do |el|
        print el.show + " "
      end
      puts
    end

    puts

  end

  # def bomb_display
  #   @board.each do |row|
  #     row.each do |el|
  #       print "* " if !el.bomb
  #       print "B " if el.bomb
  #     end
  #     puts
  #   end
  #
  #   puts
  # end

  def generate_bombs
    bombs = []
    71.times {bombs << false}
    10.times {bombs << true}
    bombs.shuffle
  end

  def all_tiles

    [].tap do |tiles|
      9.times do |r|
        9.times do |c|
          tiles << @board[r][c]
        end
      end
    end

  end


end


class Minesweeper

  def initialize
    @board = Board.new
  end

  def play

    lose = false

    while !win? && !lose

      @board.display

      puts "S to save. F to flag/unflag. ENTER to reveal a position."
      action = gets.chomp.upcase

      if action == "F"
        tile = @board[user_input]
        tile.flagged = ! tile.flagged
      elsif action == "S"
        Minesweeper.save_game(self)
        return
      else
        tile = @board[user_input]
        tile.reveal unless tile.flagged
        lose = true if tile.bomb unless tile.flagged
        puts "\nYou selected a tile that has been flagged.  No action was taken!" if tile.flagged
      end

    end



    @board.display

    puts "You Win!" if win?

    puts "YOU LOSE!" if lose

  end


  def win?

    @board.all_tiles.all? do |tile|
      tile.revealed || tile.bomb
    end
  end

  def user_input

    print "Enter your row: "
    row = gets.chomp.to_i

    print "Enter your column: "
    column = gets.chomp.to_i

    until [row,column].valid?
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
    print "Give it a name: "
    title = gets.chomp

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
