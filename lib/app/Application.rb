class Application
  attr_reader :game, :all_players, :joueur1, :joueur2
  def initialize
    @prompt = TTY::Prompt.new # Allow using the TTY::Prompt gem for minimal user graphic interface in terminal
    @replay = true
    @retour_menu = true
    welcome
    ask_name
    @all_players = []
  end

  def welcome # Welcome method
    system "clear" # We clear the Terminal for user interface issues
    puts "Le morpion est un jeu de réflexion à deux joueurs, au tour par tour et dont le but est de créer le premier un alignement sur une grille (3x3).".fit(50)
    @prompt.keypress("Appuiez sur une touche pour continuer")
  end

  def ask_name # Initialise players
    puts '-'*50
    print "Veuillez rentrer le nom du joueur1\n> "
    name1 = gets.chomp.colorize(:blue)
    @joueur1 = Player.new(name1,"x".colorize(:blue))
    print "Veuillez rentrer le nom du joueur2\n> "
    name2 = gets.chomp.colorize(:yellow)
    @joueur2 = Player.new(name2, "o".colorize(:yellow))
    @last_loser = [@joueur1, @joueur2].sample
  end

  def saving_players # Allow to store statistics of both players in a json_file
    system "clear"
    if File.exist?("db/saves.json") # If the file exits
      json_file = File.open("db/saves.json","w")
    else # Else we create a new one
      json_file = File.new("db/saves.json","w")
    end
    @all_players.each do |player| # Saving statistics of each player
      json_file.puts player.to_json
    end
    json_file.close # In order to close the file
    puts "Stats sauvegardées"
  end

  def play_app # Infinite game while @replay is true
    @replay = true
    while @replay
      @retour_menu = true # Allow return to the menu
      system "clear"
      play_game # Calling play_game method below
      while @retour_menu # While @retour_menu == true we open the Menu
        menu
      end
    end
    system "clear"
    puts "Ciao !"
  end

  def play_game # To play a whole game until a player wins
    @game = Game.new(@joueur1, @joueur2, @last_loser)
    @all_players = [@game.j1, @game.j2]
    end_game = @game.verify_endgame
    show_table
    until end_game # While end_game is false, then the game continues
      system "clear"
      show_table # Showing the actual BoardCase
      @game.place_value # Calling the place_value method in class: Game
      end_game = @game.verify_endgame  # Verifying the two issues: Win or Even
    end
    system "clear"
    show_table # Updating BoardCases values and showing the actual Board
    end_of_the_game # WE END THE GAME
  end

  def show_table # Showing the actual Board
    show = Show.new(@game)
    puts show.show_board
  end

  def end_of_the_game
    if @game.board.aborted == true # Force_quit case
      system 'clear'
      puts "Ciao !"
      exit # Receiving the order to quit the game from a player
    elsif @game.board.nb_moves == 9 # Even case
      puts "Match nul"
      @game.j1.even # Updating stats
      @game.j2.even
      @last_loser = [@game.j1, @game.j2].sample
    else
      @last_loser = @game.active_player # Initialise a loser_player (has some dependencies)
      @game.active_player.lose # Adding stats
      @game.change_active_player
      @game.active_player.win
      puts "#{@game.active_player.name} remporte la partie ! \n"
    end

  end

  def shows_statistics # In order to show the stats
    show = Show.new(@game)
    puts show.show_stats_players
  end

  def menu # Showing the menu: tree inputs possible (Stats, PlayAgain, Quit)
    choice = @prompt.select('MENU', ["Voir les stats", "Rejouer", "Quitter"], cycle: true)
    case choice
    when "Voir les stats" # To see stats
      system "clear"
      shows_statistics
      @prompt.keypress("Appuie sur une touche pour continuer")
      system "clear"
      @retour_menu = true # Menu again and again
    when "Quitter" # If a player wants to stop the game
      @replay = false
      @retour_menu = false
    else # Replay
      @retour_menu = false
    end
  end
end
