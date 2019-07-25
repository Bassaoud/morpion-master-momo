class Board
  attr_reader :cases, :nb_moves, :aborted
  def initialize # Initialising a Board with 9 empty boardcases
    a1=BoardCase.new(1)
    a2=BoardCase.new(2)
    a3=BoardCase.new(3)
    b1=BoardCase.new(4)
    b2=BoardCase.new(5)
    b3=BoardCase.new(6)
    c1=BoardCase.new(7)
    c2=BoardCase.new(8)
    c3=BoardCase.new(9)
    @cases = [a1, a2, a3, b1, b2, b3, c1, c2, c3] # Storing all BoardCases in an array
    @nb_moves = 0
    @aborted = false
  end

  def change_value_case(bcase, value) # Applying a certain value (x or o) to a specific BoardCase via position (over A1..C3)
    begin
      @cases[bcase].change_content(value)
      add_coup
    rescue
      ending_play # If one of the two players want to quit
    end
  end

  def ending_play
    @aborted = true
  end

  def add_coup
    @nb_moves += 1
  end

  def verif_alignement_points # To verify if a player wins
    if verif_lines or verif_columns or verif_diagos
      true
    else
      false
    end
  end

  def verif_lines # Rows winning condition verification
    if @cases[0].content != " " and [@cases[0].content, @cases[1].content, @cases[2].content] == [@cases[0].content, @cases[0].content, @cases[0].content]
        colorize_win(@cases[0], @cases[1], @cases[2]) # To colorize a raw due to a victory of a player
      return true
    elsif @cases[3].content != " " and [@cases[3].content, @cases[4].content, @cases[5].content] == [@cases[3].content, @cases[3].content, @cases[3].content]
      colorize_win(@cases[3], @cases[4], @cases[5])
      return true
    elsif @cases[6].content != " " and [@cases[6].content, @cases[7].content, @cases[8].content] == [@cases[6].content, @cases[6].content, @cases[6].content]
      colorize_win(@cases[6], @cases[7], @cases[8])
      return true
    else
      return false
    end
  end

  def verif_columns # Columns winning condition verification
    if @cases[0].content != " " and [@cases[0].content, @cases[3].content, @cases[6].content] == [@cases[0].content, @cases[0].content, @cases[0].content]
      colorize_win(@cases[0], @cases[3], @cases[6]) # To colorize a column due to a victory of a player
      return true
    elsif @cases[1].content != " " and [@cases[1].content, @cases[4].content, @cases[7].content] == [@cases[1].content, @cases[1].content, @cases[1].content]
      colorize_win(@cases[1], @cases[4], @cases[7])
      return true
    elsif @cases[2].content != " " and [@cases[2].content, @cases[5].content, @cases[8].content] == [@cases[2].content, @cases[2].content, @cases[2].content]
      colorize_win(@cases[2], @cases[5], @cases[8])
      return true
    else
      return false
    end

  end

  def verif_diagos # Diagonals winning condition verification
    if @cases[0].content != " " and [@cases[0].content, @cases[4].content, @cases[8].content] == [@cases[0].content, @cases[0].content, @cases[0].content]
      colorize_win(@cases[0], @cases[4], @cases[8]) # To colorize a diagonal due to a victory of a player
      return true
    elsif @cases[2].content != " " and [@cases[2].content, @cases[4].content, @cases[6].content] == [@cases[2].content, @cases[2].content, @cases[2].content]
      colorize_win(@cases[2], @cases[4], @cases[6])
      return true
    else
      return false
    end
  end

  def colorize_win(cells1, cells2, cells3) # Colorize in green _ refer to BoardCase.rb to find the change_color method!
    cells1.change_color
    cells2.change_color
    cells3.change_color
  end
end
