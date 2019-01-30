require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class MessageTest < Minitest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

end
