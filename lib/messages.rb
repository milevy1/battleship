class Messages

  def welcome_play?
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    prompt_user
  end

  def would_you_like_to_customize_ships?
    puts "How many ships should we play with?"
    puts "Enter 1 for: Cruiser(size 3) & Submarine(size 2)."
    puts "Enter 2 for: Battleship(size 4) & Cruiser(size 3) & Submarine(size 2)."
    puts "Enter 3 for: Carrier(size 5) & Battleship(size 4) & Cruiser(size 3) & Submarine(size 2)."
    puts "Enter 4 to create your own custom ships."
    prompt_user
  end

  def prompt_user_for_custom_ship_name(user_ships, user_ships_total_length, board_area)
    puts "You currently have #{user_ships.length} ships of total length #{user_ships_total_length}."
    puts "The total length of ships must be less than 1/3 the board area (#{board_area} cells)"
    puts "Enter a name for your ship # #{user_ships.length + 1}:"
    prompt_user
    return gets.chomp
  end

  def prompt_user_for_custom_ship_length(ship_name, user_ships_total_length, board_area, rows, columns)
    puts "Enter a length for your #{ship_name}:"
    prompt_user
    ship_length = gets.chomp.to_i

    if ship_length == 0
      puts "Invalid entry.  Please enter an integer."
      return prompt_user_for_custom_ship_length(ship_name, user_ships_total_length, board_area, rows, columns)
    elsif ship_length > rows && ship_length > columns
      puts "Your ship length of #{ship_length} exceeds the board size of #{rows} rows by #{columns} columns."
      puts "Please try again."
      return prompt_user_for_custom_ship_length(ship_name, user_ships_total_length, board_area, rows, columns)
    elsif ship_length + user_ships_total_length > board_area / 3
      puts "Your total ship lengths exceeds 1/3 of the board_area.  Please try again."
      return prompt_user_for_custom_ship_length(ship_name, user_ships_total_length, board_area, rows, columns)
    else
      return ship_length
    end
  end

  def succusfully_created_a_ship(ship_name, ship_length, user_ships_total_length, board_area)
    puts "You have successfully created a #{ship_name} of length #{ship_length}."

    if (user_ships_total_length + 2) > board_area / 3
      puts "There is not enough space on the board to create any more ships."
      return "N"
    end

    puts "Would you like to create another ship? (Enter Y or N)"
    input = gets.chomp.to_s.capitalize

    if input == "Y" || input == "N"
      return input
    else
      puts "You have entered an invalid selection.  Please try again."
      return succusfully_created_a_ship(ship_name, ship_length, user_ships_total_length, board_area)
    end
  end

  def here_are_all_your_ships_you_created(user_ships)
    puts "Here is a list of all your ships you created:"
    user_ships.each { |ship|
      puts "#{ship[0]} of size #{ship[1]}"
    }
  end

  def invalid_customize_ship_selection
    puts "You have entered an invalid selection.  Please try again."
    would_you_like_to_customize_ships?
  end

  def board_is_too_small_for_ship_selection
    puts "The board must be at least 3 times the size of all the ships.  Please try again."
  end

  def column_choose
    puts "How many columns do you want for your board"
    puts "No input / non-numeric input defaults to 4"
    prompt_user
  end

  def column_choice(columns)
    puts "You are playing with #{columns} columns"
  end

  def row_choice(rows)
    puts "You are playing with #{rows} rows"
  end

  def row_choose
    puts "How many rows do you want for your board"
    puts "No input / non-numeric input defaults to 4"
    prompt_user
  end

  def prompt_user
    print "> "
  end

  def player_ship_placement_intro(ships, render)

    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your #{ships.length} ships."

    ships.each do |ship|
      puts "The #{ship.name} is #{ship.length} long;"
    end

    puts render
  end

  def player_ship_placement_input(ship)
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
    prompt_user
  end

  def ship_placement_invalid_coordinates
    puts "Those are invalid coordinates. Please try again:"
    prompt_user
  end

  def computer_board(computer_board)
    puts "=============COMPUTER BOARD============="
    puts computer_board.render
  end

  def player_board(player_board)
    puts "==============PLAYER BOARD=============="
    puts player_board.render(true)
  end

  def player_shot_prompt
    puts "Enter the coordinate for your shot:"
    prompt_user
  end


  def choose_difficulty
    puts "What difficulty level would you like?"
    puts "Input 'e' for easy"
    puts "Input 'm' for medium"
    prompt_user
  end

  def player_shot_invalid_coordinate
    puts "You have entered an invalid coordinate.  Please try again."
  end

  def player_shot_already_fired_upon
    puts "That coordinate was already fired upon."
  end

  def player_shot_results(coordinate, board)
    puts "Your shot on " + coordinate + shot_feedback(coordinate,board)
  end

  def computer_shot_results(coordinate, board)
    puts "My shot on " + coordinate + shot_feedback(coordinate,board)
  end

  def shot_feedback(coordinate, board)
    case board.cells[coordinate].render
    when "M"
      " was a miss."
    when "H"
      " hit a ship!"
    when "X"
      " sunk the #{board.cells[coordinate].ship.name}!"
    end
  end

  def player_wins_message
    puts "Congratulations! You have won!"
  end

  def computer_wins_message
    puts "You have lost to a computer built by students in their 2nd week of code school. FAIL!"
  end

end
