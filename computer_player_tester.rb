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

comp_player.place_own_ships
puts comp_board.render(true)

(1..16).each {|n| coord = comp_player.random_shot
  player_board.cells[coord].fire_upon
  p coord
}
