class CircularQueue
  def initialize(size)
    @queue = Array.new(size)
    @max_size = size
    @size = 0
    @input_idx = 0
  end

  def enqueue(value)
    @queue[@input_idx] = value
    @input_idx = (@input_idx + 1) % @max_size
    @size += 1 unless @size == @max_size
    value
  end

  def dequeue()
    return nil if @size.zero?
    output_idx = (@input_idx - @size) % @max_size
    output = @queue[output_idx]
    @queue[output_idx] = nil
    @size -= 1
    output
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil