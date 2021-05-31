module Dog
  class Doggy;end
end

class Cat
  attr_reader :name
  
  include Dog
  
  def initialize
    Dog::Doggy.new
  end
end

me = Cat.new

puts me