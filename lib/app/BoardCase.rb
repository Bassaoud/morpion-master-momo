class BoardCase
  attr_reader :content
  def initialize(position) # Initialise a specific BoardCase via position
    @position = position
    @content = " "
  end

  def change_content(value)
    @content = value
  end

  def change_color
    @content = @content.colorize(:green) # In order to colorize cells, refer to Board.colorize_win to understand
  end
end
