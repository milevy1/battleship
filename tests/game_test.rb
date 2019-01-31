require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/messages'
require './lib/game'
require './lib/computer_player'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_game_runs
    @game.main_menu
  end

end
