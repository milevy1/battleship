class Messages

  def self.welcome_play?
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    self.prompt_user
  end

  def self.would_you_like_to_customize_ships?
    puts "How many ships should we play with?"
    puts "Enter 1 for: Cruiser(size 3) & Submarine(size 2)."
    puts "Enter 2 for: Battleship(size 4) & Cruiser(size 3) & Submarine(size 2)."
    puts "Enter 3 for: Carrier(size 5) & Battleship(size 4) & Cruiser(size 3) & Submarine(size 2)."
    puts "Enter 4 to create your own custom ships."
    self.prompt_user
  end

  def self. no_more_room_for_ships
    puts "That's all the room for ships you have!"
  end

  def self.prompt_user_for_custom_ship_name(user_ships, remaining_ship_length)
    puts "You currently have #{user_ships.length} ships."
    puts "Additional ships may take up no more than #{remaining_ship_length} cells"
    puts "Enter a name for your ship # #{user_ships.length + 1}:"
    self.prompt_user
  end

  def self.prompt_user_for_custom_ship_length(ship_name, remaining_ship_length)
    puts "Enter a length for your #{ship_name}:"
    puts "Must be greater than 2 and less than #{remaining_ship_length}"
    self.prompt_user
  end

  def self.succusfully_created_a_ship(ship_name, ship_length)
    puts "You have successfully created a #{ship_name} of length #{ship_length}."
  end

  def self.another_ship?
    puts "Want to create another ship? Enter [Y] or [N]."
    self.prompt_user
  end
  def self.here_are_all_your_ships_you_created(user_ships)
    puts "Here is a list of all your ships you created:"
    user_ships.each do |ship|
      puts "#{ship[0]} of size #{ship[1]}"
    end
  end

  def self.board_is_too_small_for_ship_selection
    puts "The board must be at least 3 times the size of all the ships.  Please try again."
  end

  def self.column_choose
    puts "How many columns do you want for your board (4 <= columns <= 26)"
    puts "No input / invalid input defaults to 4"
    self.prompt_user
  end

  def self.column_choice(columns)
    puts "You are playing with #{columns} columns"
  end

  def self.row_choice(rows)
    puts "You are playing with #{rows} rows"
  end

  def self.row_choose
    puts "How many rows do you want for your board (4 <= rows <= 26)"
    puts "No input / invalid input defaults to 4"
    self.prompt_user
  end

  def self.prompt_user
    print "> "
  end

  def self.player_ship_placement_intro(ships, render)

    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your #{ships.length} ships."

    ships.each do |ship|
      puts "The #{ship.name} is #{ship.length} long;"
    end

    puts render
  end

  def self.player_ship_placement_input(ship)
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
    self.prompt_user
  end

  def self.ship_placement_invalid_coordinates
    puts "Those are invalid coordinates. Please try again:"
    self.prompt_user
  end

  def self.computer_board(computer_board)
    puts "=============COMPUTER BOARD============="
    puts computer_board.render
  end

  def self.player_board(player_board)
    puts "==============PLAYER BOARD=============="
    puts player_board.render(true)
  end

  def self.player_shot_prompt
    puts "Enter the coordinate for your shot:"
    self.prompt_user
  end

  def self.choose_difficulty
    puts "What difficulty level would you like?"
    puts "Input 'e' for easy"
    puts "Input 'h' for hard"
    self.prompt_user
  end

  def self.invalid_input
    puts "Invalid input; please try again"
  end

  def self.player_shot_invalid_coordinate
    puts "You have entered an invalid coordinate.  Please try again."
  end

  def self.player_shot_already_fired_upon
    puts "That coordinate was already fired upon."
  end

  def self.player_shot_results(coordinate, board)
    puts "Your shot on " + coordinate + shot_feedback(coordinate,board)
  end

  def self.computer_shot_results(coordinate, board)
    puts "My shot on " + coordinate + shot_feedback(coordinate,board)
  end

  def self.shot_feedback(coordinate, board)
    case board.cells[coordinate].render
    when "M"
      " was a miss."
    when "H"
      " hit a ship!"
    when "X"
      " sunk the #{board.cells[coordinate].ship.name}!"
    end
  end

  def self.player_wins_message
    puts "Congratulations! You have won!"
  end

  def self.computer_wins_message
    puts "You have lost to a computer built by students in their 2nd week of code school. FAIL!"
  end

  def self.tie_game_message
    puts "It is a draw.  We both sunk our last ships on the same turn."
  end

end
