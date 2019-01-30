require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/messages'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_setup_game_output
    expected = "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit.\n> "

    assert_output(expected) { @game.setup_game }
  end

end
