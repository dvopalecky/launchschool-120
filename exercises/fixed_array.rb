class FixedArray
  def initialize(nb_of_elements)
    @data = Array.new(nb_of_elements)
  end

  def [](idx)
    raise IndexError if idx >= @data.size || idx < -@data.size
    @data[idx]
  end

  def []=(idx, value)
    raise IndexError if idx >= @data.size || idx < -@data.size
    @data[idx] = value
  end

  def to_a
    @data.clone
  end

  def to_s
    "[" + @data.map(&:inspect).join(', ') + "]"
  end
end

# Tests
fixed_array = FixedArray.new(5)
puts fixed_array[3].nil?
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end
