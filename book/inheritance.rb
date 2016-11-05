module Swimmable
  def swim
    "#{@name}: I'm swimming"
  end
end

class Animal
  attr_accessor :name

  def speak
    "Hello"
  end

  def initialize(name)
    @name = name
  end
end

class Fish < Animal
  include Swimmable
end

module Mammal
  class Dog < Animal
    include Swimmable

    def speak
      super + " Woof"
    end

    def initialize(color)
      super
      @color = color
    end
  end

  class Cat < Animal
    def initialize(color)
      super("unknown cat")
      @color = color
    end
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

module Car
  def self.break_down
    puts "Car broke down"
  end
end

def Car::repair
  puts "Car was repaired"
end

dog1 = Mammal::Dog.new("brown")
catty = Mammal::Cat.new("yellow")
nemo = Fish.new("Nemo")

p bruno = GoodDog.new("brown")        # => #<GoodDog:0x007fb40b1e6718 @color="brown", @name="brown">

p dog1
p catty
p nemo
p dog1.speak
p catty.speak
p nemo.swim
p dog1.swim
p Mammal::Dog.ancestors

Car.break_down()
Car.repair()
