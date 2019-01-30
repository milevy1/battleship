class Cell
  attr_reader :coordinate, :ship #, :empty?

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    return @ship == nil
  end

  def place_ship(ship)
    if @ship == nil
      @ship = ship
    end
  end

  def fire_upon

    if @ship && !@fired_upon
      @ship.hit
    end

    @fired_upon = true

  end

  def fired_upon?
    return @fired_upon
  end

  def render(debug = false)
    if @ship == nil
      if @fired_upon
        return "M"
      else
        return "."
      end
    else # There is a ship
      if @fired_upon
        if @ship.sunk?
          return "X"
        else
          return "H"
        end
      else # Not fired upon
        if debug
          return "S"
        else
          return "."
        end
      end
    end

    # return "H" if @ship != nil && @fired_upon == true
    # return "S" if @ship != nil && debug == true
    # return "." if @fired_upon == false
    # return "M" if @ship == nil && @fired_upon == true
    # return "X" if @ship != nil && @ship.sunk?


  end
end
