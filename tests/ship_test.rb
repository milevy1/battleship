require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_ship_has_initial_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
    assert_equal 3, @cruiser.health
    assert_equal false, @cruiser.sunk?
  end

  def test_ship_attributes_change_after_hits
    @cruiser.hit
    assert_equal 2, @cruiser.health
    assert_equal false, @cruiser.sunk?

    @cruiser.hit
    assert_equal 1, @cruiser.health
    assert_equal false, @cruiser.sunk?

    @cruiser.hit
    assert_equal true, @cruiser.sunk?
  end

end
