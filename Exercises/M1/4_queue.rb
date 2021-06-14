class CircularQueue
  def initialize(size)
    @queue = Array.new(size)
  end
  
  def enqueue(object)
    @queue.each_with_index do |element, index|
      if queue_filled?
        @queue << object
        return @queue.shift
      elsif queue_empty?
        @queue[0] = object
        return
      else
        @queue[index] != nil ? next : @queue[index] = object
      end
    end
  end
  
  def dequeue
    @queue << nil
    @queue.shift
  end
  
  def queue_filled?
    @queue.all? { |element| element != nil }
  end
  
  def queue_empty?
    @queue.all? { |element| element == nil }
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