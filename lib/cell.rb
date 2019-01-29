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
    @fired_upon = true
    if @ship && !@fired_upon
      @ship.hit
    end
  end

  def fired_upon?
    return @fired_upon
  end

  def render(debug = false)
    return "S" if @ship != nil && debug == true
    return "X" if @ship != nil && @ship.sunk?
    return "." if @fired_upon == false
    return "M" if @ship == nil && @fired_upon == true
    return "H" if @ship != nil && @fired_upon == true

  end
end
