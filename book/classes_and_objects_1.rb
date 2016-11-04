# OOP: Classes and Objects - Part I

class Person
  attr_accessor :name, :height, :weight

  def initialize(name, height, weight)
    @name = name
    @height = height
    @weight = weight
    puts "new person #{name()} is born"
  end

  def speak
    "Hi, I'm #{name}"
  end

  def name
    @name.upcase
  end

  def change_info(name, height, weight)
    self.name = name
    self.height = height
    self.weight = weight
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end

danny = Person.new("Danny", 180, 70)
danny.height = 32
danny.change_info("Daniel", 100, 1000)
puts danny.info

class MyCar
  attr_accessor :color
  attr_reader :year, :model, :speed

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up
    @speed += 10
  end

  def brake
    @speed -= 10
    @speed = 0 if @speed < 0
  end

  def turn_off
    @speed = 0
  end

  def spray_paint(color)
    self.color = color
  end
end

# Exercise 1
# Create a class called MyCar. When you initialize a new instance or object of
# the class, allow the user to define some instance variables that tell us the
# year, color, and model of the car. Create an instance variable that is set
# to 0 during instantiation of the object to track the current speed of the car
# as well. Create instance methods that allow the car to speed up, brake, and
# shut the car off.

audi = MyCar.new(2014, "black", "Audi A6")
3.times { audi.speed_up }
p audi.speed
6.times { audi.brake }
p audi.speed
audi.spray_paint("yellow")
audi.color = "red"
p audi.color
p audi.year