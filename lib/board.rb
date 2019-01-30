require 'pry'

class Board
  attr_reader :cells

  def initialize(rows = 4, columns = 4)
    @rows = rows
    @columns = columns
    @cells = build_initial_cells
  end

  def build_initial_cells
    cell_hash = {}
    number_range = 1..@columns
    letter_range = 65.chr..(65+@rows-1).chr

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

    if coordinate_array.any?{ |coordinate| @cells[coordinate].ship }
      return false
    end

    rows_from_input = coordinate_array.map { |coordinate| coordinate[0]}
    columns_from_input = coordinate_array.map { |coordinate| coordinate[1..-1].to_i}

    in_row = rows_from_input.uniq.length == 1
    in_column = columns_from_input.uniq.length == 1

    return false if !in_row && !in_column

    possible_number_sequences = []
    (1..@columns).each_cons(ship.length) { |sequence|
      possible_number_sequences << sequence}

    possible_letter_sequences = []
    (65.chr..(65+@rows-1).chr).each_cons(ship.length) { |sequence|
      possible_letter_sequences << sequence}

    if in_row
      return false if !possible_number_sequences.include?(columns_from_input)
    else
      return false if !possible_letter_sequences.include?(rows_from_input)
    end

    return true

  end

  def place(ship, coordinate_array)
    if valid_placement?(ship, coordinate_array)
      coordinate_array.each { |coordinate|
        @cells[coordinate].place_ship(ship) }
    end
  end

  def render(debug = false)

    column_values = (1..@columns)
    row_values = (65.chr..(65+@rows-1).chr)

    header_row ="  " + (1..@columns).map{|n| n.to_s}.join(" ") + " \n"
    board_rows = []

    row_values.each{ |row|
      row_string = row + " "
      column_values.each{ |col|
        cell_coordinate = row + col.to_s
        row_string += @cells[cell_coordinate].render(debug) + " "
      }
      board_rows << row_string + "\n"
    }

    return header_row + [board_rows].join

  end

end
