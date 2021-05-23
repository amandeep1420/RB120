class Pet
  attr_reader :name, :age, :color
  
  def initialize(name, age, color)
    @name = name
    @age = age
    @color = color
  end
end

class Cat < Pet
  def to_s
    "My cat #{self.name} is #{self.age} years old and has #{self.color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch