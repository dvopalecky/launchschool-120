# Create a superclass called Vehicle for your MyCar class to inherit from and
# move the behavior that isn't specific to the MyCar class to the superclass.
# Create a constant in your MyCar class that stores information about the
# vehicle that makes it different from other types of Vehicles.

# Then create a new class called MyTruck that inherits from your superclass
# that also has a constant defined that separates it from the MyCar class
# in some way.

module Loadable
  def load_cargo
    puts 'Loading Cargo'
  end
end

class Vehicle
  NUMBER_OF_DOORS = 0
  @@nb_vehicles = 0
  attr_accessor :color
  attr_reader :year, :model, :speed

  def self.nb_vehicles
    puts 'We have #{@@nb_vehicles} vehicles'
  end

  def initialize(year, color, model)
    @speed = 0
    @year = year
    @color = color
    @model = model
    @@nb_vehicles += 1
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

  def age
    "#{@model} age: #{calculate_age} years"
  end

  private

  def calculate_age
    Time.new.year - @year
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

class MyTruck < Vehicle
  include Loadable
  NUMBER_OF_DOORS = 2
end

class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other)
    grade > other.grade
  end

  protected

  attr_reader :grade
end

audi = MyCar.new(2016, 'yellow', 'Audi')
audi.speed_up
p audi.speed
truck = MyTruck.new(2000, 'red', 'Renault')
4.times { truck.speed_up }
p truck.speed
Vehicle.nb_vehicles
tatra = MyTruck.new(1998, 'white', 'Tatra')
Vehicle.nb_vehicles
tatra.load_cargo

puts 'MyCar ancestors'
p MyCar.ancestors
puts 'MyTruck ancestors'
p MyTruck.ancestors
puts 'Vehicle ancestors'
p Vehicle.ancestors
tatra.spray_paint('red')
p tatra.color
p tatra.age
p Vehicle::NUMBER_OF_DOORS

joe = Student.new('Joe', 71)
bob = Student.new('Bob', 70)
p joe.better_grade_than?(bob)
