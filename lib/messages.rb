class Messages

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    prompt_user
  end

  def prompt_user
    print "> "
  end

  def player_ship_placement_intro(player_board)
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is two units long and the Submarine is three units long."
    puts player_board.render(true)
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

  def player_shot_invalid_coordinate
    puts "You have entered an invalid coordinate.  Please try again."
  end

  def player_shot_already_fired_upon
    puts "That coordinate was already fired upon."
    player_shot_prompt
  end

  def shot_results
    # This needs work with game logic for coordinates
    # and result (miss/hit/sunk)
    puts "Your shot on A4 was a miss."
    puts "My shot on C1 was a miss."
  end

  def player_wins_message
    puts "Congratulations! You have won!"
  end

  def computer_wins_message
    puts "You have lost to a computer built by students in their 2nd week of code school. FAIL!"
  end

end
