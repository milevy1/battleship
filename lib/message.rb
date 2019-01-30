class Message

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
  end

  def prompt_user
    print "> "
  end

  def player_ship_placement_intro
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is two units long and the Submarine is three units long."
  end

  def player_ship_placement_input(ship)
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
  end

  def ship_placement_invalid_coordinates
    puts "Those are invalid coordinates. Please try again:"
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
  end

  def player_shot_invalid_coordinate
    puts "Please enter a valid coordinate:"
  end

end
