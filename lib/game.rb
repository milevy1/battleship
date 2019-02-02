class Game
  attr_reader :message, :player_board, :computer_board, :computer_player

  def initialize
    @message = Messages.new
  end

  def main_menu
    @message.welcome_play?
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

    rows, columns = solicit_board_size
    board_area = rows * columns
    ship_attributes = select_ship_attributes(board_area, rows, columns)
    @difficulty_level = select_difficulty_level ## Not done yet

    player_ships = ship_attributes.map{ |attrs| Ship.new(*attrs)}
    computer_ships = ship_attributes.map{ |attrs| Ship.new(*attrs)}

    @player_board = Board.new(rows, columns, player_ships)
    @computer_board = Board.new(rows, columns, computer_ships)


    @computer_player = ComputerPlayer.new(@player_board,
                                          @computer_board)
    @computer_player.place_own_ships

    @player_board.place_user_ships(@message)
    # @message.player_ship_placement_intro(@player_board, player_ships)
    #
    # player_ships.each { |ship|
    #   @message.player_ship_placement_input(ship)
    #   while !@player_board.place(ship, gets.chomp.upcase.split)
    #     @message.ship_placement_invalid_coordinates
    #   end
    #   puts @player_board.render(true)
    #  }

     play
  end

  def select_difficulty_level
    @message.choose_difficulty
    ###
  end

  def select_ship_attributes(board_area, rows, columns)

    @message.would_you_like_to_customize_ships?
    valid_selections = [1, 2, 3, 4]
    ship_selection = gets.chomp.to_i

    until valid_selections.include?(ship_selection)
      @message.invalid_customize_ship_selection
      ship_selection = gets.chomp.to_i
    end

    # Ship lengths must be < 1/3 of the board area to play
    case ship_selection
    when 1
      if (board_area / 3) < 5
        @message.board_is_too_small_for_ship_selection
        return select_ship_attributes(board_area)
      end
      return [['Cruiser', 3],['Submarine', 2]]
    when 2
      if (board_area / 3) < 9
        @message.board_is_too_small_for_ship_selection
        return select_ship_attributes(board_area)
      end
      return [['Battleship', 4],['Cruiser', 3],['Submarine', 2]]
    when 3
      if (board_area / 3) < 14
        @message.board_is_too_small_for_ship_selection
        return select_ship_attributes(board_area)
      end
      return [['Carrier', 5],['Battleship', 4],['Cruiser', 3],['Submarine', 2]]
    when 4
      return user_custom_ships(board_area, rows, columns)
    end

  end

  def user_custom_ships(board_area, rows, columns)
    user_input = "Y"
    user_ships = []
    user_ships_total_length = user_ships.map { |ship| ship[1] }.inject(0){ |sum, x| sum + x }

    until user_input == "N"
      ship_name  = @message.prompt_user_for_custom_ship_name(user_ships, user_ships_total_length, board_area)
      ship_length = @message.prompt_user_for_custom_ship_length(ship_name, user_ships_total_length, board_area, rows, columns)

      user_ships << [ship_name, ship_length]

      user_input = @message.succusfully_created_a_ship(ship_name, ship_length)
    end

    @message.here_are_all_your_ships_you_created(user_ships)
    return user_ships
  end

  def solicit_board_size

    @message.column_choose
    columns = get_user_integer
    columns = 4 if columns == 0
    @message.column_choice(columns)

    @message.row_choose
    rows = get_user_integer
    rows = 4 if rows ==0
    @message.row_choice(rows)

    return rows, columns
  end

  def get_user_integer
    input = gets.chomp.to_i
  end

  def play
    while @player_board.has_unsunk_ship? && @computer_board.has_unsunk_ship?
      @message.computer_board(@computer_board)
      @message.player_board(@player_board)

      @message.player_shot_results(player_shot, @computer_board)

      @message.computer_shot_results(computer_shot, @player_board)
    end

    results

    main_menu
  end

  def results
    ### Implement logic for a tie?
    if @player_board.has_unsunk_ship?
      @message.player_wins_message
    else
      @message.computer_wins_message
    end
  end

  def player_shot

    loop do
      @message.player_shot_prompt
      coordinate = gets.chomp.upcase

      if !@computer_board.valid_coordinate?(coordinate)
        @message.player_shot_invalid_coordinate
      elsif @computer_board.cells[coordinate].fired_upon?
        @message.player_shot_already_fired_upon
      else
        @computer_board.fire_upon(coordinate)
        return coordinate
      end
    end
  end

  def computer_shot
    coordinate = @computer_player.random_shot
    @player_board.fire_upon(coordinate)
    return coordinate
  end

  # def has_an_unsunk_ship(board)
  #   board.cells.values.each { |cell|
  #     return true if cell.ship && !cell.ship.sunk?
  #   }
  #   return false
  # end

end
