class Person
  def name=(name)
    @first, @last = name.split # or split, save, manually assign each one
  end
  
  def name
    [@first, @last].join(' ') # or @first + ' ' + @last
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name