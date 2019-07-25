class Player
  attr_reader :name, :symbol
  def initialize(name, symbol,nb_plays = 0, nb_win=0, nb_lose=0, nb_even=0 )
    @name = name
    @symbol = symbol
    @nb_win = nb_win
    @nb_lose = nb_lose
    @nb_even = nb_even
    @nb_plays = nb_plays
  end

  def win # Statistics
    @nb_win += 1
    add_plays
  end
  def lose
    @nb_lose += 1
    add_plays
  end
  def even
    @nb_even += 1
    add_plays
  end
  def add_plays
    @nb_plays += 1
  end

  def show_states
    {
      "First name" => @name,
      "Number of games played" => @nb_plays,
      "Number of Wins" => @nb_win,
      "Number of Losses" => @nb_lose,
      "Number of Evens" => @nb_even
    }
  end
end
