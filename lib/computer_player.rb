class ComputerPlayer

  def initialize(opponent_board, own_board, ships_to_place)
    @opponent_board = opponent_board
    @own_board = own_board
    @ships_to_place = ships_to_place
  end

  def place_own_ships

    @ships_to_place.each{ |ship|
      potential_placements = find_potential_placements(ship.length)

    }
  end

  def find_potential_placements(length)
    potential_placements = []
    potential_placements += column_placements(length)
    potential_placements += row_placements(length)
    return potential_placements
  end

  def row_placements(length)
    potential_placements = []

    (1..@own_board.columns).each_cons(ship.length){
      |column_sequence|
      (65.chr..(65+@own_board.rows-1).chr).each {
        |row|
        potential_placements << column_sequence.map { |column| row + column.to_s}
      }
    }
  end

  def cloumn_placements(length)
    potential_placements = []

    (65.chr..(65+@own_board.rows-1).chr).each_cons(ship.length){
      |row_sequence|
      (1..@own_board.columns).each {
        |column|
        potential_placements << column_sequence.map { |row| row + column.to_s}
      }
    }
  end
end
