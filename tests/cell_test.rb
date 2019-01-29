require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_cell_has_initial_attributes
    assert_equal "B4", @cell.coordinate
    assert_equal nil, @cell.ship
    assert_equal true, @cell.empty? # Should be method?
  end

  def test_cell_attributes_change_after_placing_a_ship
    @cell.place_ship(@cruiser)

    assert_equal @cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end

  def test_cell_cannot_place_ship_if_already_occupied_by_a_ship
    skip
    # This will be a good test to do later
    # I'm wondering if this should be in the board_test.rb?
  end

  def test_cell_attributes_change_after_fired_upon
    @cell.place_ship(@cruiser)

    assert_equal false, @cell.fired_upon?

    @cell.fire_upon

    assert_equal 2, @cell.ship.health
    assert_equal true, @cell.fired_upon?
  end

  def test_cell_renders_M_after_a_missed_fire
    assert_equal ".", @cell.render

    @cell.fire_upon

    assert_equal "M", @cell.render
  end

  def test_cell_renders_S_when_calling_render_true
    @cell.place_ship(@cruiser)

    assert_equal ".", @cell.render
    assert_equal "S", @cell.render(true)
  end

  def test_cell_renders_H_after_fired_upon
    @cell.place_ship(@cruiser)

    @cell.fire_upon

    assert_equal "H", @cell.render
  end

  def test_cell_renders_X_after_ship_sunk
    @cell.place_ship(@cruiser)
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit

    assert_equal "X", @cell.render
  end

end
