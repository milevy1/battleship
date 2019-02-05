require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer_player'
require './lib/messages'

class ComputerPlayerTest < Minitest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    default_ships = [@cruiser, @submarine]
    @comp_board = Board.new(4,4,default_ships)#(@dim)
    @player_board = Board.new(4,4,default_ships)

    @comp_player = ComputerPlayer.new(@player_board,
                                      @comp_board)
    @player_board.place(Ship.new("test",3), ["A1","A2","A3"])

  end

  def test_place_own_ships_places_all_ships
    @comp_player.place_own_ships

    ships_placed = []

    ships_placed = @comp_board.cells.keys.find_all{
      |coordinate|
      @comp_board.cells[coordinate].ship != nil}

    ships_placed = ships_placed.map{
      |coordinate|
      @comp_board.cells[coordinate].ship.name}

    assert_equal 2, ships_placed.uniq.length
  end

  def test_placed_ships_occupy_correct_number_cells
    @comp_player.place_own_ships

    ship_cells = @comp_board.cells.keys.count{
    |coordinate|
    @comp_board.cells[coordinate].ship != nil}

    assert_equal 5, ship_cells
  end

  def test_random_shot_returns_valid_coordinate
    shot_coordinate = @comp_player.random_shot

    assert @comp_board.valid_coordinate?(shot_coordinate)
  end


### Test that ships are placed

### Test Check that number of cells containing ships is combined length of ships

# test one more cell has been fired upon
end
