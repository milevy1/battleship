require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class CellTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)

    @board_large = Board.new(5, 6)
  end

  def test_it_has_correct_number_cells
    expected_cells = 16 # @dim * @dim

    cell_hash = @board.cells

    assert_equal expected_cells, cell_hash.keys.length
  end

  def test_large_board_has_correct_number_cells
    expected_cells = 30

    cell_hash = @board_large.cells

    assert_equal expected_cells, cell_hash.keys.length
  end

  def test_each_cell_is_a_cell
    cell_hash = @board.cells

    cell_hash.values.each { |cell| assert_instance_of Cell, cell}
  end

  def test_large_board_each_cell_is_a_cell
    cell_hash = @board_large.cells

    cell_hash.values.each { |cell| assert_instance_of Cell, cell}
  end

  def test_each_cell_coordinate_in_board
    dim = 4
    columns = (1..(dim)).to_a
    rows = (65.chr..(65+dim-1).chr).to_a

    cell_hash = @board.cells

    cell_hash.keys.each do |coordinate|
      assert rows.include?(coordinate[0])
      assert columns.include?(coordinate[1..-1].to_i)
    end
  end

  def test_place_fills_correct_cells
    skip
    ###
  end

  def test_valid_coordinates
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
  end

  def test_valid_placement_requires_correct_number_of_coordinates
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A2", "A3", "A4"])
  end

  def test_valid_placement_requires_cells_to_be_consecutive
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
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

end
