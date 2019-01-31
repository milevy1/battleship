class Game
  attr_reader :message, :player_board, :computer_board, :computer_player

  def initialize
    @message = Messages.new
  end

  def main_menu
    @message.main_menu
    play_input = gets.chomp.downcase
    if play_input == "p"
      setup_game
    elsif play_input == "q"
      # Quits game
    else
      puts "Invalid input, please try again."
      main_menu
    end
  end

  def setup_game
    @player_board = Board.new
    player_cruiser = Ship.new("Cruiser", 3)
    player_submarine = Ship.new("Submarine", 2)
    player_ships = [player_cruiser, player_submarine]
    @computer_board = Board.new
    computer_cruiser = Ship.new("Cruiser", 3)
    computer_submarine = Ship.new("Submarine", 2)
    computer_ships = [computer_cruiser, computer_submarine]
    @computer_player = ComputerPlayer.new(@player_board, @computer_board, computer_ships)
    @computer_player.place_own_ships

    @message.player_ship_placement_intro(@player_board)

    player_ships.each { |ship|
      @message.player_ship_placement_input(ship)
      while !@player_board.place(ship, gets.chomp.split)
        @message.ship_placement_invalid_coordinates
      end
      puts @player_board.render(true)
     }
  end

end
