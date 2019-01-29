class Ship

  attr_reader :name, :length, :health #, sunk

  def initialize(name, length)
    @name = name
    @length = length
    @health = @length
  end

  def hit
    @health -= 1
  end

  def sunk?
    return @health <= 0
  end

end
