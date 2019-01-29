require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
# Testing pushing to Williams pull request

class CellTest < Minitest::Test

  def setup
    # For iteration 4
    # @dim = 4

    @board = Board.new#(@dim)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_has_correct_number_cells
    expected_cells = 16 # @dim * @dim

    cell_hash = @board.cells

    assert_equal expected_cells, cell_hash.keys.length
  end

  def test_each_cell_is_a_cell
    cell_hash = @board.cells

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


end
