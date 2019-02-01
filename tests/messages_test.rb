require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/messages'

class MessagesTest < Minitest::Test

  def setup
    @message = Messages.new
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_player_ship_placement_input
    expected = "Enter the squares for the Cruiser (3 spaces):\n "

    assert_output (expected) { @message.player_ship_placement_input(@cruiser) }
  end

end
