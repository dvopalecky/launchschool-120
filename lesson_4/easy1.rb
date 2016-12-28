# Object Oriented Programming > Lesson 4: OO Exercises > Exercises: Easy 1
# Question 1
p true.class
p "hello".class
p [1, 2, 3, "happy days"].class
p 142.class

# Question 2
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

class Tatra < Truck
end

skoda = Car.new
skoda.go_slow
skoda.go_fast

tatra = Tatra.new
tatra.go_very_slow
tatra.go_fast

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

apple = Fruit.new("apple")
margherita = Pizza.new("Margherita")

p apple.instance_variables
p margherita.instance_variables

class Cube
  #attr_accessor :volume
  def initialize(volume)
    @volume = volume
  end
end

kostka = Cube.new(13)
p kostka.instance_variable_get("@volums")

puts kostka.to_s

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

suitcase = Bag.new(1,2)
p suitcase