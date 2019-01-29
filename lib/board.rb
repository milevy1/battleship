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

end
