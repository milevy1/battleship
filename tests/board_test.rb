require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/messages'

class CellTest < Minitest::Test

  def setup
    @carrier = Ship.new("Carrier", 5)
    @battleship = Ship.new("Battleship", 4)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    default_ships = [@cruiser, @submarine]

    @board = Board.new(4,4, default_ships)
    @board_large = Board.new(5, 6, default_ships)
    @board_10 = Board.new(10, 10, default_ships)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_has_correct_number_cells
    expected_cells = 16

    cell_hash = @board.cells

    assert_equal expected_cells, cell_hash.keys.length
  end

  def test_larger_boards_has_correct_number_cells
    cell_hash_large = @board_large.cells
    cell_hash_10 = @board_10.cells

    assert_equal 30, cell_hash_large.keys.length
    assert_equal 100, cell_hash_10.keys.length
  end

  def test_each_cell_is_a_cell
    cell_hash = @board.cells

    cell_hash.values.each { |cell| assert_instance_of Cell, cell}
  end

  def test_larger_boards_each_cell_is_a_cell
    cell_hash_large = @board_large.cells
    cell_hash_10 = @board_10.cells

    cell_hash_large.values.each { |cell| assert_instance_of Cell, cell}
    cell_hash_10.values.each { |cell| assert_instance_of Cell, cell}
  end

  def test_each_cell_coordinate_in_board
    columns = (1..4).to_a
    rows = ("A".."D").to_a

    cell_hash = @board.cells

    cell_hash.keys.each do |coordinate|
      assert rows.include?(coordinate[0])
      assert columns.include?(coordinate[1..-1].to_i)
    end
  end

  def test_place_fills_correct_cells
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal @board.cells["A1"].ship, @cruiser
    assert_equal @board.cells["A2"].ship, @cruiser
    assert_equal @board.cells["A3"].ship, @cruiser
  end

  def test_valid_coordinates
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")

    assert_equal true, @board_large.valid_coordinate?("E1")
    assert_equal false, @board_large.valid_coordinate?("F1")

    assert_equal true, @board_10.valid_coordinate?("J10")
    assert_equal true, @board_10.valid_coordinate?("A1")
    assert_equal false, @board_10.valid_coordinate?("K1")
    assert_equal false, @board_10.valid_coordinate?("A11")
  end

  def test_any_coordinates_invalid
    assert_equal false, @board.any_coordinates_invalid(["A1", "A2", "A3"])
    assert_equal true, @board.any_coordinates_invalid(["A3", "A4", "A5"])
  end

  def test_valid_placement_requires_correct_number_of_coordinates
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A2", "A3", "A4"])

    assert_equal true, @board_large.valid_placement?(@carrier, ["A1", "A2", "A3", "A4", "A5"])
    assert_equal false, @board_large.valid_placement?(@battleship, ["A1", "A2", "A3"])
    assert_equal false, @board_large.valid_placement?(@battleship, ["A1", "A2", "A3", "A4", "A5"])
  end

  def test_ship_and_coordinate_lengths_differ
    assert_equal true, @board.lengths_differ(@cruiser, ["A1", "A2"])
    assert_equal false, @board.lengths_differ(@cruiser, ["A1", "A2", "A3"])
  end

  def test_valid_placement_requires_cells_to_be_consecutive
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
  end

  def test_coordinates_not_consecutive
    assert_equal true, @board.coordinates_not_consecutive(@submarine, ["B1", "D3"])
    assert_equal false, @board.coordinates_not_consecutive(@cruiser, ["C2", "C3", "C4"])
  end

  def test_valid_placement_requires_cells_to_be_in_order
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"])
  end

  def test_valid_placement_requires_cells_not_diagnal
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_valid_placement_for_valid_cells
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
    assert_equal true, @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
    assert_equal true, @board_10.valid_placement?(@cruiser, ["A8", "A9", "A10"])
  end

  def test_one_ship_can_occupy_multiple_cells
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]
    assert_equal cell_3.ship, cell_2.ship
  end

  def test_valid_placement_checks_that_ships_do_not_overlap
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal false, @board.valid_placement?(@submarine, ["A1", "B1"])
  end

  def test_any_coordinates_already_hold_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal true, @board.any_coordinates_already_hold_ship(["A3", "B3"])
    assert_equal false, @board.any_coordinates_already_hold_ship(["B4", "C4", "D4"])
  end

  def test_board_renders
    @board.place(@cruiser, ["A1","A2","A3"])

    normal_render = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    debug_render = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"

    assert_equal normal_render, @board.render
    assert_equal debug_render, @board.render(true)

    @board.cells['A1'].fire_upon
    @board.cells['D4'].fire_upon

    normal_render_fire2 = "  1 2 3 4 \nA H . . . \nB . . . . \nC . . . . \nD . . . M \n"
    debug_render_fire2 = "  1 2 3 4 \nA H S S . \nB . . . . \nC . . . . \nD . . . M \n"

    assert_equal normal_render_fire2, @board.render
    assert_equal debug_render_fire2, @board.render(true)

    @board.cells['A2'].fire_upon
    @board.cells['A3'].fire_upon

    normal_render_sunk = "  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . M \n"
    debug_render_sunk = "  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . M \n"

    assert_equal normal_render_sunk, @board.render
    assert_equal debug_render_sunk, @board.render(true)
  end

  def test_large_board_renders
    @board_large.place(@carrier, ["A1", "A2", "A3", "A4", "A5"])
    normal_render = "  1 2 3 4 5 6 \nA . . . . . . \nB . . . . . . \nC . . . . . . \nD . . . . . . \nE . . . . . . \n"
    debug_render = "  1 2 3 4 5 6 \nA S S S S S . \nB . . . . . . \nC . . . . . . \nD . . . . . . \nE . . . . . . \n"

    assert_equal normal_render, @board_large.render
    assert_equal debug_render, @board_large.render(true)

    @board_large.cells['A1'].fire_upon
    @board_large.cells['A2'].fire_upon
    @board_large.cells['A3'].fire_upon
    @board_large.cells['A4'].fire_upon

    normal_render_fire4 = "  1 2 3 4 5 6 \nA H H H H . . \nB . . . . . . \nC . . . . . . \nD . . . . . . \nE . . . . . . \n"
    debug_render_fire4 = "  1 2 3 4 5 6 \nA H H H H S . \nB . . . . . . \nC . . . . . . \nD . . . . . . \nE . . . . . . \n"

    assert_equal normal_render_fire4, @board_large.render
    assert_equal debug_render_fire4, @board_large.render(true)

    @board_large.cells['A5'].fire_upon

    normal_render_sunk = "  1 2 3 4 5 6 \nA X X X X X . \nB . . . . . . \nC . . . . . . \nD . . . . . . \nE . . . . . . \n"
    debug_render_sunk = "  1 2 3 4 5 6 \nA X X X X X . \nB . . . . . . \nC . . . . . . \nD . . . . . . \nE . . . . . . \n"

    assert_equal normal_render_sunk, @board_large.render
    assert_equal debug_render_sunk, @board_large.render(true)
  end

end
