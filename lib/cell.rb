class Cell
  attr_reader :coordinate #, :empty?
  attr_accessor :ship

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
    return "S" if @ship != nil && debug == true
    return "." if @fired_upon == false && debug == false
    return "M" if @ship == nil && @fired_upon == true
    return "X" if @ship != nil && @ship.sunk?
    return "H" if @ship != nil && @fired_upon == true

  end
end
