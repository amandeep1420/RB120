class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def change_name
    p name
    name = 1
    p name
  end
end

bob = Person.new('Bob')
p bob.name 
bob.change_name
p bob.name