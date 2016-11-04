class MyCar
  attr_accessor :brand, :model, :year

  def initialize(brand, model, year)
    self.brand = brand
    self.model = model
    self.year = year
  end

  def to_s
    "This car: #{self.brand} #{self.model}, year #{self.year}"
  end

  def self.milleage(distance_miles, consumed_gallons)
    "#{distance_miles / consumed_gallons.to_f} miles per gallon"
  end
end

class GoodDog
  DOG_YEARS = 7
  @@number_of_dogs = 0

  attr_accessor :name, :age

  def initialize(name, age)
    @@number_of_dogs += 1
    self.name = name
    self.age = age * DOG_YEARS
  end

  def to_s
    "This is Dog with name #{@name} and age #{@age}"
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end

  def what_is_self
    self
  end

  puts self
end

dog1 = GoodDog.new("Sparky", 4)
dog2 = GoodDog.new("Fido", 1)
puts "Hello #{dog1}"
p dog1
p dog1.age
p GoodDog.total_number_of_dogs
p dog1.what_is_self
p GoodDog
p MyCar.milleage(100, 23)
car1 = MyCar.new("Skoda", "Fabia", 2014)
puts car1

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
p bob.name
