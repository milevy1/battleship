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
    return false if ship.length == coordinate_array.length

    if coordinate_array.any?{ |coordinate| !valid_coordinate?(coordinate)}
      return false
    end

    rows = coordinate_array.map { |coordinate| coordinate[0]}
    columns = coordinate_array.map { |coordinate| coordinate[1..-1].to_i}

    in_row = rows.count(rows[0]) == rows.length
    in_column = columns.count(column[0]) == columns.length

    return false if !in_row && !in_column

    if in_row
      test_consecutive = columns
    else
      test_consecutive = rows
    end

    non_consecutive = test_consecutive.any?.with_index do |coordinate, index|
      if index != 0
        coordinate.to_i != test_consecutive[index-1].to_i +1
      end
    end

    return !non_consecutive


  end

end
