module Dense
  def density
    mass / volume
  end
end

class Body
  include Comparable
  attr_reader :mass

  def initialize(mass)
    @mass = mass
  end

  def <=>(other)
    mass <=> other.mass
  end
end

class SphericalBody < Body
  include Dense
  attr_reader :radius

  def initialize(mass, radius)
    super(mass)
    @radius = radius
  end

  def volume
    4 / 3 * Math::PI * radius**3
  end
end

class Moon < SphericalBody
end

class Planet < SphericalBody
  def initialize(mass, radius)
    super
    @satellites = []
  end
end

class Star
end

class Asteroid < Body
end

earth = Planet.new(10, 2)
moon = Moon.new(5, 1)
p earth > moon
