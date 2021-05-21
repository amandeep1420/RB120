class Person
  def name
    @name
  end
  
  def name=(x)
    @name = x
  end
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name

# or just attr_accessor :name
# or separate attr_reader and attr_writer, both with :name