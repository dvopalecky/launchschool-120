class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greet = Greeting.new
    greet.greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

Hello.hi

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
#tv.manufacturer
tv.model

Television.manufacturer
#Television.model

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older

    self.age=(self.age + 1) #age() + 1
  end
end

catty = Cat.new("english")
catty.make_one_year_older
p catty.age
