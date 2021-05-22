#1.

# class Person
#   def initialize(name)
#     @name = name
#   end
  
#   def name=(name)
#     @name = name
#   end
  
#   def name
#     @name
#   end
# end

#or

# class Person
#   attr_accessor :name
  
#   def initialize(name)
#     @name = name
#   end
# end


# bob = Person.new('bob')
# p bob.name                  # => 'bob'
# bob.name = 'Robert'
# p bob.name                  # => 'Robert'

#2, 3, 4

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    set_names(name)
  end
  
  def name=(name)
    set_names(name)
  end
    
  def name
    last_name == '' ? first_name : "#{first_name} #{last_name}"
  end
  
  def callable(person)
    compare_names(person)
  end
  
  def does_this_work
    what
  end
  
  def to_s
    name
  end
  
  private
  
  def set_names(n)
    names       = n.split(' ')
    @first_name = names.first
    @last_name  = names.size > 1 ? names.last : ''
  end
    
end

# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# p bob.first_name            # => 'John'
# p bob.last_name             # => 'Adams'

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"