class Person
  def name=(n)
    splitted = n.split
    @name = splitted[0]
    @surname = splitted[1]
  end

  def name
    [@name, @surname].join(' ')
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name
