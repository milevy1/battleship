class Board
  attr_reader :cells, :rows, :columns, :ships

  def initialize(rows=4, columns=4, ship_list=[])
    @rows = rows
    @columns = columns
    @ships = ship_list
    @cells = build_initial_cells
  end

  def build_initial_cells
    cell_hash = {}
    number_range = 1..@columns
    letter_range = "A"..(("A".ord)+@rows-1).chr

    number_range.each do |number|
      letter_range.each do |letter|
        coordinate = letter + number.to_s
        cell_hash[coordinate] = Cell.new(coordinate)
      end
    end

    return cell_hash
  end

  def place_user_ships
    Messages.player_ship_placement_intro(@ships, render(true))
    @ships.each do |ship|
      Messages.player_ship_placement_input(ship)
      while !place(ship, gets.chomp.upcase.split)
        Messages.ship_placement_invalid_coordinates
      end
      puts render(true)
    end
  end

  def has_unsunk_ship?
    @ships.any?{ |ship| !ship.sunk? }
  end

  def fire_upon(coordinate)
    @cells[coordinate].fire_upon
  end

  def place(ship, coordinate_array)
    if valid_placement?(ship, coordinate_array)
      coordinate_array.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
      return true
    else
      return false
    end
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinate_array)
    return false if lengths_differ(ship, coordinate_array)
    return false if any_coordinates_invalid(coordinate_array)
    return false if any_coordinates_already_hold_ship(coordinate_array)
    return false if coordinates_not_consecutive(ship, coordinate_array)
    # All validations passed, therefore it is a valid placement
    return true
  end

  def lengths_differ(ship, coordinate_array)
    return ship.length != coordinate_array.length
  end

  def any_coordinates_invalid(coordinate_array)
    return coordinate_array.any?{ |coordinate| !valid_coordinate?(coordinate) }
  end

  def any_coordinates_already_hold_ship(coordinate_array)
    return coordinate_array.any?{ |coordinate| @cells[coordinate].ship }
  end

  def coordinates_not_consecutive(ship, coordinate_array)
    rows_from_input = coordinate_array.map { |coordinate| coordinate[0] }
    columns_from_input = coordinate_array.map { |coordinate| coordinate[1..-1].to_i }

    coordinate_orientation = coordinates_in_row_or_column(coordinate_array,
                                                          rows_from_input,
                                                          columns_from_input)
    return true if coordinate_orientation == false

    # If in row, check if column is sequential
    if coordinate_orientation == "rows"
      possible_number_sequences = []
      (1..@columns).each_cons(ship.length) do |sequence|
        possible_number_sequences << sequence
      end
      return true if !possible_number_sequences.include?(columns_from_input)

    # If in column, check if row is sequential
    else
      possible_letter_sequences = []
      ("A"..("A".ord+@rows-1).chr).each_cons(ship.length) do |sequence|
        possible_letter_sequences << sequence
      end
      return true if !possible_letter_sequences.include?(rows_from_input)
    end

    # Coordinates in row or column; Coordinates sequential
    # Thus not_consecutive is false
    return false
  end

  def coordinates_in_row_or_column(coordinate_array, rows_from_input, columns_from_input)
    # Test if all in one row or one column

    if rows_from_input.uniq.length == 1
      return "rows"
    elsif columns_from_input.uniq.length == 1
      return "columns"
    else
      return false
    end
  end

  def render(debug = false)

    column_values = (1..@columns)
    row_values = ("A"..(("A".ord)+@rows-1).chr)

    if @columns <= 9
      header_row ="  " + (1..@columns).map{|n| n.to_s}.join(" ") + " \n"
    else
      header_row = (" " * 20) + (10..@columns).map { |n| n.to_s[0] }.join(" ") + " \n"
      header_row += "  " + (1..9).map{|n| n.to_s}.join(" ") + " "
      header_row += (10..@columns).map { |n| n.to_s[1] }.join(" ") + " \n"
    end

    board_rows = []

    row_values.each do |row|
      row_string = row + " "
      column_values.each do |col|
        cell_coordinate = row + col.to_s
        row_string += @cells[cell_coordinate].render(debug) + " "
      end
      board_rows << row_string + "\n"
    end

    return header_row + [board_rows].join

  end



end
