class Cell
  attr_reader :coordinate, :ship #, :empty?

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false # Should this be just the method?
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
    if !@fired_upon
      @fired_upon = true
      if @ship
        @ship.hit
      end
    end
  end

  def fired_upon?
    return @fired_upon
  end

  def render(debug = false)
    return "." if @fired_upon == false
    return "M" if @ship == nil && @fired_upon == true
    return "X" if @ship.sunk?
    return "H" if @ship != nil && @fired_upon == true
    return "S" if @ship != nil && debug == true
  end
end
