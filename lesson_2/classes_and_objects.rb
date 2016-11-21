class Person1
  attr_accessor :name

  def initialize(n)
    self.name = n
  end
end

class Person2
  attr_accessor :first_name, :last_name

  def initialize(n)
    parse_full_name(n)
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def name=(n)
    parse_full_name(n)
  end

  def ==(other)
    @first_name == other.first_name &&
      @last_name == other.last_name
  end

  def to_s
    name
  end

  private

  def parse_full_name(name)
    parts = name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end
end

#1
puts "Ex. 1"
bob = Person1.new('bob')
p bob.name                  # => 'bob'
bob.name = 'Robert'
p bob.name                  # => 'Robert'

#2
puts "Ex. 2"
bob = Person2.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'
# 3
bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'
# 4
bob = Person2.new('Robert Smith')
rob = Person2.new('Robert Smith')
p bob == rob

#5
bob = Person2.new("Robert Smith")
puts "The person's name is: #{bob.name}"
puts "The person's name is: #{bob}"