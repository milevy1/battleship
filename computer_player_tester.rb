require './lib/computer_player'
require './lib/cell'
require './lib/board'
require './lib/ship'

comp_board = Board.new#(@dim)
player_board = Board.new
cruiser = Ship.new("Cruiser", 3)
submarine = Ship.new("Submarine", 2)
comp_player = ComputerPlayer.new(player_board,
                                  comp_board,
                                  [cruiser, submarine])

player_board.place(Ship.new("test",3), ["A1","A2","A3"])
comp_player.place_own_ships
puts comp_board.render(true)

(1..16).each {|n| coord = comp_player.smart_shot
  player_board.cells[coord].fire_upon
  p coord
}

### Test that ships are placed

### Test Check that number of cells containing ships is combined length of ships

# test one more cell has been fired upon
