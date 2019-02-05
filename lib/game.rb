class Game

  def main_menu
    Messages.welcome_play?
    play_input = gets.chomp.upcase

    until ["P","Q"].include?(play_input)
      Messages.invalid_input
      play_input = gets.chomp.upcase
    end

    if play_input == "P"
      setup_game
    else
      # Quits game
    end
  end

  def setup_game
    rows, columns = solicit_board_size

    ship_attributes = select_ship_attributes( rows, columns)
    @difficulty_level = select_difficulty_level

    player_ships = ship_attributes.map{ |attrs| Ship.new(*attrs)}
    computer_ships = ship_attributes.map{ |attrs| Ship.new(*attrs)}

    @player_board = Board.new(rows, columns, player_ships)
    @computer_board = Board.new(rows, columns, computer_ships)

    @computer_player = ComputerPlayer.new(@player_board,
                                          @computer_board)
    @computer_player.place_own_ships
    @player_board.place_user_ships

     play
  end

  def select_difficulty_level
    Messages.choose_difficulty
    player_choice = gets.chomp
    until ['E','H'].include?(player_choice.upcase)
      Messages.invalid_input
      player_choice = gets.chomp
    end
    return player_choice
  end

  def select_ship_attributes(rows, columns)
    board_area = rows * columns
    Messages.would_you_like_to_customize_ships?
    valid_selections = [1, 2, 3, 4]
    ship_selection = gets.chomp.to_i

    until valid_selections.include?(ship_selection)
      Messages.invalid_input
      ship_selection = gets.chomp.to_i
    end

    # Ship lengths must be < 1/3 of the board area to play
    case ship_selection
    when 1 # Smallest possible board allows these ships
      return [['Cruiser', 3],['Submarine', 2]]

    when 2
      if (board_area / 3) < 9
        Messages.board_is_too_small_for_ship_selection
        return select_ship_attributes( rows, columns)
      end
      return [['Battleship', 4],['Cruiser', 3],['Submarine', 2]]

    when 3
      if (board_area / 3) < 14
        Messages.board_is_too_small_for_ship_selection
        return select_ship_attributes(rows, columns)
      end
      return [['Carrier', 5],['Battleship', 4],['Cruiser', 3],['Submarine', 2]]

    when 4
      return user_custom_ships(rows, columns)
    end
  end

  def user_custom_ships(rows, columns)
    potential_ship_length = (rows * columns)/3
    user_input = "Y"
    user_ships = []
    remaining_ship_length = potential_ship_length
    # Loop until user_input "N"
    until user_input == "N"

      Messages.prompt_user_for_custom_ship_name(user_ships, remaining_ship_length)

      ship_name  = gets.chomp
      # Check to make sure name is not empty and not already in use
      until ship_name != "" && !user_ships.map{|ship| ship[0]}.include?(ship_name)
        Messages.invalid_input
        ship_name = gets.chomp
      end

      Messages.prompt_user_for_custom_ship_length(ship_name, remaining_ship_length)

      ship_length = gets.chomp.to_i
      until (2..remaining_ship_length).include?(ship_length)
        Messages.invalid_input
        ship_length = gets.chomp.to_i
      end

      user_ships << [ship_name, ship_length]

      Messages.succusfully_created_a_ship(ship_name, ship_length)

      remaining_ship_length = potential_ship_length - user_ships.sum{ |ship| ship[1] }

      if remaining_ship_length < 2
        Messages.no_more_room_for_ships
        break
      end

      Messages.another_ship?

      user_input = gets.chomp
      until ["Y","N"].include?(user_input.upcase)
        Messages.invalid_input
        user_input = gets.chomp
      end
    end

    Messages.here_are_all_your_ships_you_created(user_ships)
    return user_ships
  end

  def solicit_board_size

    Messages.column_choose
    columns = gets.chomp.to_i
    columns = 4 if !(4..26).include?(columns)
    Messages.column_choice(columns)

    Messages.row_choose
    rows = gets.chomp.to_i
    rows = 4 if !(4..26).include?(rows)
    Messages.row_choice(rows)

    return rows, columns
  end

  def play
    while @player_board.has_unsunk_ship? && @computer_board.has_unsunk_ship?
      Messages.computer_board(@computer_board)
      Messages.player_board(@player_board)

      Messages.player_shot_results(player_shot, @computer_board)

      Messages.computer_shot_results(computer_shot, @player_board)
    end

    results

    main_menu
  end

  def results
    if !@player_board.has_unsunk_ship? && !@computer_board.has_unsunk_ship?
      Messages.tie_game_message
    elsif @player_board.has_unsunk_ship?
      Messages.player_wins_message
    else
      Messages.computer_wins_message
    end
  end

  def player_shot
    loop do
      Messages.player_shot_prompt
      coordinate = gets.chomp.upcase

      if !@computer_board.valid_coordinate?(coordinate)
        Messages.player_shot_invalid_coordinate
      elsif @computer_board.cells[coordinate].fired_upon?
        Messages.player_shot_already_fired_upon
      else
        @computer_board.fire_upon(coordinate)
        return coordinate
      end
    end
  end

  def computer_shot
    if @difficulty == 'E'
      coordinate = @computer_player.random_shot
    else
      coordinate = @computer_player.smart_shot
    end

    @player_board.fire_upon(coordinate)
    return coordinate
  end

end
