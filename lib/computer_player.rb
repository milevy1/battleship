class ComputerPlayer

  def initialize(opponent_board, own_board)
    @opponent_board = opponent_board
    @own_board = own_board
  end

  def place_own_ships
    @own_board.ships.each do |ship|
      potential_placements = find_potential_placements(ship.length)

      until @own_board.place(ship, potential_placements.shuffle.first)
      end
    end
  end

  def random_shot(potential_shot_locations = nil)
    if potential_shot_locations == nil

      potential_shot_locations = @opponent_board.cells.keys.find_all do |cell_coord|
        !@opponent_board.cells[cell_coord].fired_upon?
      end
    end

    return potential_shot_locations.shuffle.first
  end

  def smart_shot
    hit_locations = @opponent_board.cells.keys.find_all do |cell_coord|
      cell = @opponent_board.cells[cell_coord]
      cell.fired_upon? && cell.ship != nil && !cell.ship.sunk?
    end

    if hit_locations == []
      return random_shot
    end
    potential_shot_locations = []
    hit_locations.each do |cell_coord|
      adjacent = find_adjacent(cell_coord)
      potential_shot_locations = potential_shot_locations.concat(adjacent)
    end
    potential_shot_locations.uniq!
    potential_shot_locations = potential_shot_locations.find_all do
      |coordinate|
      !@opponent_board.cells[coordinate].fired_upon?
    end

    return random_shot(potential_shot_locations)
  end

  def find_adjacent(cell_coordinate)

    coord_row = cell_coordinate[0]
    coord_column = cell_coordinate[1..-1].to_i
    adjacent_coordinates = [
          (coord_row.ord-1).chr+coord_column.to_s,
          (coord_row.ord+1).chr+coord_column.to_s,
          coord_row+(coord_column-1).to_s,
          coord_row + (coord_column+1).to_s
          ]

    return adjacent_coordinates.keep_if{ |coord| @opponent_board.cells.keys.include?(coord)}
  end

  def find_potential_placements(length)
    potential_placements = []
    potential_placements += column_placements(length)
    potential_placements += row_placements(length)
    return potential_placements
  end

  def row_placements(length)
    potential_placements = []

    (1..@own_board.columns).each_cons(length) do |column_sequence|
      ("A"..(("A".ord) +@own_board.rows-1).chr).each do |row|
        potential_placements << column_sequence.map{ |column| row + column.to_s }
      end
    end

    return potential_placements
  end

  def column_placements(length)
    potential_placements = []

    ("A".chr..("A".ord+@own_board.rows-1).chr).each_cons(length) do |row_sequence|
      (1..@own_board.columns).each do |column|
        potential_placements << row_sequence.map { |row| row + column.to_s}
      end
    end

    return potential_placements
  end
end
