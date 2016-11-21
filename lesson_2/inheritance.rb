class Animal
  def jump
    'jumping!'
  end

  def run
    'running!'
  end
end

class Dog < Animal
  def speak
    'Bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class Cat < Animal
  def speak
    'Meow!'
  end
end

class BullDog < Dog
  def swim
    "can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"
bulldog = BullDog.new
puts bulldog.swim


# 3 Class hiearchy
# Animal (run, jump)
# - Dog (fetch, speak, swim)
#   - BullDog (swim)
# - Cat (speak)