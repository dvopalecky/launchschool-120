# test garbage collection

class Matrix
  attr_accessor :matrix

  def initialize
    @matrix = []
    1000000.times { @matrix << rand}
  end
end

m = nil
100.times do |i|
  m = Matrix.new
  p i + 1
end

puts "end of program"
