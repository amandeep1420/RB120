class Cat
  def self.generic_greeting # technically able to define it as def Cat.generic_greeting as well
    puts "Hello! I'm a cat!"
  end
end

kitty = Cat.new
puts kitty.class
kitty.class.generic_greeting