class Towers

  attr_accessor :stacks

  def initialize
    @stacks = [[3,2,1],[],[]]

  end

  def prompt
    gets.chomp
  end

  def move(stack_from, stack_to)

    unless stacks[stack_to].empty?
      if  stacks[stack_from].last > stacks[stack_to].last
        return false
      end
    end
    disc = stacks[stack_from].pop
    stacks[stack_to] << disc
  end

  def gameover?
    if stacks[1..2].any? {|stack| stack == [3,2,1]}
       true
    else
     false
   end
  end

  def parse(string)
    string = string.split(",").map {|char| char.to_i}
  end


end
