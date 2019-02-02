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
    # puts "Enter 4 for total customization."
    prompt_user
  end

  def invalid_customize_ship_selection
    puts "You have entered an invalid selection.  Please try again."
    would_you_like_to_customize_ships
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
