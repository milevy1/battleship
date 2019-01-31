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
     start
  end

  def start
    while #...
      @message.computer_board(@computer_board)
      @message.player_board(@player_board)
      player_shot_coordinate = player_turn
      @message.player_shot_results(player_shot_coordinate, player_shot_feedback(player_shot_coordinate, @computer_board))
      computer_shot_coordinate = computer_turn
      @message.computer_shot_results(computer_shot_coordinate, player_shot_feedback(computer_shot_coordinate, @player_board))
    end
    
  end

  def player_turn
    @message.player_shot_prompt
    input = gets.chomp
    if !@computer_board.valid_coordinate?(input)
      @message.player_shot_invalid_coordinate
      player_turn
    elsif @computer_board.cells[input].fired_upon?
      @message.player_shot_already_fired_upon
      player_turn
    else
      @computer_board.cells[input].fire_upon
    end
    return input
  end

  def computer_turn
    coordinate = @computer_player.random_shot
    @player_board.cells[coordinate].fire_upon
    return coordinate
  end

  def player_shot_feedback(coordinate, board)
    case board.cells[coordinate].render
    when "M"
      " was a miss."
    when "H"
      " hit a ship!"
    when "X"
      " sunk a ship!"
    end
  end

end
