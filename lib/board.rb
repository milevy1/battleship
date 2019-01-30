require 'pry'

class Board
  attr_reader :cells

  def initialize(dim = 4)
    @dim = dim
    @cells = build_initial_cells(@dim)
  end

  def build_initial_cells(dim)
    cell_hash = {}
    number_range = 1..dim
    letter_range = 65.chr..(65+dim-1).chr

    number_range.each { |number|
      letter_range.each { |letter|
        coordinate = letter + number.to_s
        cell_hash[coordinate] = Cell.new(coordinate)
       }
     }
     return cell_hash
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinate_array)
    return false if ship.length != coordinate_array.length

    if coordinate_array.any?{ |coordinate| !valid_coordinate?(coordinate)}
      return false
    end

    rows = coordinate_array.map { |coordinate| coordinate[0]}
    columns = coordinate_array.map { |coordinate| coordinate[1..-1].to_i}

    in_row = rows.uniq.length == 1
    in_column = columns.uniq.length == 1

    return false if !in_row && !in_column

    possible_number_sequences = []
    (1..@dim).each_cons(ship.length) { |sequence|
      possible_number_sequences << sequence}

    possible_letter_sequences = []
    (65.chr..(65+@dim-1).chr).each_cons(ship.length) { |sequence|
      possible_letter_sequences << sequence}

    if in_row
      return false if !possible_number_sequences.include?(columns)
    else
      return false if !possible_letter_sequences.include?(rows)
    end

    return true

  end

  def place(ship, coordinate_array)
    if valid_placement?(ship, coordinate_array)
      coordinate_array.each { |coordinate|
        @cells[coordinate].ship = ship }
    end
  end

end
