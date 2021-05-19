
# # # class GoodDog
# # # end

# # # class HumanBeing
# # # end

# # # sparky = GoodDog.new

# # # bob = HumanBeing.new

# # # module Speak
# # #   def speak(sound)
# # #     puts sound
# # #   end
# # # end

# # # class GoodDog
# # #   include Speak
# # # end

# # # class HumanBeing
# # #   include Speak
# # # end

# # # sparky.speak('meow')
# # # bob.speak('heh')

# # # puts "--GoodDog ancestors--"
# # # puts GoodDog.ancestors
# # # puts "--HumanBeing ancestors--"
# # # puts HumanBeing.ancestors


# # =begin
# # How do we create an object in Ruby? Give an example of the creation of an object.

# # String.new
# # Integer.new
# # Array.new

# # We use the new instance method?

# # Not quite. We create an object by defining a class and instantiating it by using
# # the `new` method to crate an instance, also known as an object.

# # class BigGuy
# # end

# # jeff = BigGuy.new
# # =end

# # =begin
# # What is a module? What is its purpose? 
# # How do we use them with our classes? 
# # Create a module for the class you created in exercise 1 and include it properly.

# # A module allows a class to access various methods via 'mixing-in'...
# # You use them with a class by 'calling' (?) a class, using the include method with the module

# # A module allows us to group reusable code into one place; we use modules in our classes by using the 
# # `include` method invocation, followed by the module name. Modules are also used as a namespace....

# # ...you can create new classes within modules; this allows you to organize them.
# # When 
# # =end


# # module Height
# #   def height(feet)
# #     puts feet
# #   end
# # end

# # module Careers
# #   class Engineer
# #   end
  
# #   class Teacher
# #   end
# # end

# # class BigGuy
# #   include Height
# # end

# # jeff = BigGuy.new

# # # jeff.height(6)

# # jeff_upgrade = Careers::Engineer.new

# # # puts jeff_upgrade.class

# # # instantiate the object by calling the "new" instance method on the class and 
# # # ......


# # module Meow
# #   def meow
# #     puts "meow"
# #   end
# # end

# # class WhiteMouse
# #   include Meow
# # end


# # stuart = WhiteMouse.new

# # # stuart.meow



# # # a module allows you to expand the functionality of a class; modules must be mixed-into a class to access their functionality
# # # you can declare new classes in a module...


# # module GruffMeow
# #   def gruff_meow
# #     puts "Mrrroowww"
# #   end
# # end

# # module CuteMeow
# #   def cute_meow
# #     puts "Mew"
# #   end
# # end

# # module Cats
# #   class Calico
# #     include GruffMeow
# #   end
  
# #   class Tabby
# #     include CuteMeow
# #   end
# # end

# # calico = Cats::Calico.new

# # tabby = Cats::Tabby.new

# # # calico.gruff_meow

# # # tabby.cute_meow

# # # p Cats::Tabby.ancestors

# # # ----------------------------------------------------------------------


# # class GoodDog
# #   def initialize(name)
# #     @name = name
# #   end
  
# #   def get_name
# #     @name
# #   end
  
# #   def set_name=(name)
# #     @name = name
# #   end
  
# #   def speak
# #     "#{@name} says \"Arf!\""
# #   end
# # end

# # sparky = GoodDog.new("Sparky")

# # # puts sparky.speak

# # # puts sparky.get_name

# # # sparky.set_name = "Spartacus"

# # # puts sparky.get_name

# # # turns into....

# # class GoodDog
# #   attr_accessor :name, :height, :weight
  
# #   def initialize(n, h, w)
# #     @name = n
# #     @height = h
# #     @weight = w
# #   end

# #   def speak
# #     "#{name} says meow!"
# #   end
  
# #   def change_info(n, h, w)
# #     self.name = n
# #     self.height = h
# #     self.weight = w
# #   end
  
# #   def info
# #     "#{name} weighs #{weight} and is #{height} tall."
# #   end
# # end

# # # sparky = GoodDog.new("Sparky", "12 inches", "10 lbs")

# # # puts sparky.info

# # # sparky.change_info("Spartacus the God", "200 feet", "3 tons")

# # # puts sparky.info

# # #-----------------------------------------------------

# # class MyCar
# #   attr_accessor :color
# #   attr_reader :year
  
# #   def initialize(year, color, model)
# #     @year = year
# #     @color = color
# #     @model = model
# #     @speed = 0
# #   end
  
# #   def speed_up(n)
# #     @speed += n
# #     puts "Speeding up! Your current speed is #{@speed}."
# #   end
  
# #   def slow_down(n)
# #     @speed -= n
# #     puts "Slowing down! Your current speed is #{@speed}."
# #   end
  
# #   def spray_paint(color)
# #     self.color = color
# #     puts "Primrose is now #{color}!"
# #   end
  
# #   def shut_off
# #     @speed = 0
# #     puts "Time to take a break! The car is now shut off."
# #   end

# #   def info
# #     "Our car, which is a #{@color} #{@year} #{@model}, has a current speed of #{@speed} MPH."
# #   end
# # end

# # primrose = MyCar.new(2012, "Burgundy", "VW Passat")

# # # puts primrose.info
# # # puts primrose.color
# # # primrose.spray_paint("Yellow")
# # # puts primrose.info




# # #--------

# # class GoodDog
# #   DOG_YEARS = 7
  
# #   attr_accessor :name, :age
  
# #   @@number_of_dogs = 0
  
# #   def initialize(name, age)
# #     self.name = name
# #     self.age  = age * DOG_YEARS     # note the alignment of the = here
# #     @@number_of_dogs += 1
# #   end
  
# #   def self.what_am_i
# #     puts "I'm a GoodDog class! I'm being used to learn OOP! :D"
# #   end
  
# #   def self.dog_count
# #     @@number_of_dogs
# #   end
  
# #   def to_s
# #     "This dog's name is #{name} and it is #{age} in dog years."
# #   end
  
# #   def what
# #     "#{age}"
# #   end
# # end
# # good_boy = GoodDog.new("Zoomer", 2)


# # puts "#{good_boy}"
# #---------------------------------------

# # class GoodDog
# #   attr_accessor :name, :height, :weight

# #   def initialize(n, h, w)
# #     self.name   = n
# #     self.height = h
# #     self.weight = w
# #   end

# #   def change_info(n, h, w)
# #     self.name   = n
# #     self.height = h
# #     self.weight = w
# #   end

# #   def info
# #     "#{self.name} weighs #{self.weight} and is #{self.height} tall."
# #   end
  
# #   def what_is_self
# #     self
# #   end
# #   # puts self
# # end





# # class MyCar
# #   attr_accessor :color, :year, :model
  
# #   def self.calculate_mileage(miles_traveled, gallons)
# #     "The caluculated mileage is #{miles_traveled / gallons} MPG!"
# #   end
  
# #   def initialize(year, color, model)
# #     @year = year
# #     @color = color
# #     @model = model
# #     @speed = 0
# #   end
  
# #   def speed_up(n)
# #     @speed += n
# #     puts "Speeding up! Your current speed is #{@speed}."
# #   end
  
# #   def slow_down(n)
# #     @speed -= n
# #     puts "Slowing down! Your current speed is #{@speed}."
# #   end
  
# #   def spray_paint(color)
# #     self.color = color
# #     puts "Primrose is now #{color}!"
# #   end
  
# #   def shut_off
# #     @speed = 0
# #     puts "Time to take a break! The car is now shut off."
# #   end

# #   def to_s
# #     "This car is a #{color} #{year} #{model}."
# #   end
# # end

# # # puts MyCar.calculate_mileage(250, 10)

# # camry = MyCar.new(2005, "red", "Toyota Camry")

# # puts camry

# # 3. change attr_reader to attr_accessor, or manually define a setter method for @name

# #-----------------------

# # class MyCar
  
# #   def self.calculate_mileage(tank, miles)
# #     puts "The mileage for this car is #{miles/tank} MPG."
# #   end
  
# #   def to_s
# #     puts self
# #   end
# # end
# #---------------------------


# # class Animal
# #   attr_accessor :name
  
# #   def initialize
# #     puts "A new animal has been manifested in this reality."
# #   end
# # end

# # class GoodDog < Animal
# #   def initialize(color)
# #     super
# #     @color = color
# #   end
# # end

# # class BadDog < Animal
# #   attr_reader :age, :name
  
# #   def initialize(age, name)
# #     super()
# #     @age = age
# #   end
# # end

# # #-----------------------------

# # module Swimmable
# #   def swim
# #     puts "I'm a #{self.fish_type} and I'm swimming!"
# #   end
# # end

# # class Animal; end

# # class Fish < Animal
# #   attr_accessor :fish_type
  
# #   def initialize(fish_type)
# #     self.fish_type = fish_type
# #   end
  
# #   include Swimmable
# # end

# # class Mammal < Animal
# # end

# # class Cat < Mammal
# # end

# # carp = Fish.new("Carp")

# # carp.swim

# #-----------------------------

# # module Walkable
# #   def walk
# #     "I'm walking."
# #   end
# # end

# # module Swimmable
# #   def swim
# #     "I'm swimming."
# #   end
# # end

# # module Climbable
# #   def climb
# #     "I'm climbing."
# #   end
# # end

# # class Animal
# #   include Walkable
  
# #   def speak
# #     "I'm an animal - and I speak!"
# #   end
# # end

# # class GoodDog < Animal
# #   include Swimmable
# #   include Climbable
# # end

# module Mammal
#   class Dog
#     def speak(sound)
#       p "#{sound}"
#     end
#   end
  
#   class Cat
#     def say_name(name)
#       p "#{name}"
#     end
#   end
  
#   def self.random_method(num)
#     num ** 2
#   end
# end

# # class GoodDog
  
# #   DOG_YEARS = 7
  
# #   attr_accessor :name, :age
  
# #   def initialize(n, a)
# #     self.name = n
# #     self.age = a
# #   end
  
# #   def public_disclosure
# #     "#{self.name} in human years is #{human_years}."
# #   end
  
# #   private
  
# #   def human_years
# #     age * DOG_YEARS
# #   end
# # end

# # sparky = GoodDog.new("Sparky", 4)
# # puts sparky.public_disclosure

# # class Animal
# #   def a_public_method
# #     "Will this work? " + self.a_protected_method
# #   end
  
# #   protected
  
# #   def a_protected_method
# #     "Yes, I'm protected!"
# #   end
  
# #   def meow
# #     "Meow"
# #   end
# # end

# # fido = Animal.new

# # puts fido.a_public_method

# # p fido.protected_methods

# class Parent
#   def say_hi
#     p "Hi from Parent."
#   end
# end

# class Child < Parent
#   def say_hi
#     p "Hi from Child."
#   end
  
#   def send
#     p "send from Child..."
#   end
  
#   def to_s
#   puts "Do not do this; I am a Child. I will punch you."
#   end
# end

# c = Child.new

# c.to_s

#---------------------------------------

module Haulable
  def haulable?
    true
  end
end

class Vehicle
  attr_accessor :color, :year, :model, :speed
  
  @@number_of_vehicles = 0
    
  def self.calculate_mileage(tank, miles)
    puts "The mileage is #{miles/tank} MPG."
  end
  
  def self.count
    puts "#{@@number_of_vehicles} vehicles have been created."
  end
  
  def initialize(year, color, model)
    self.year = year
    self.color = color
    self.model = model
    self.speed = 0
    @@number_of_vehicles +=1
  end
  
  def speed_up(n)
    self.speed += n
    puts "Speeding up! Your current speed is #{speed}."
  end
  
  def slow_down(n)
    self.speed -= n
    puts "Slowing down! Your current speed is #{speed}."
  end
  
  def spray_paint(color)
    self.color = color
    puts "Primrose is now #{color}!"
  end
  
  def shut_off
    self.speed = 0
    puts "Time to take a break! The car is now shut off."
  end
  
  def to_s
    "This vehicle is a #{color} #{year} #{model}."
  end
  
  def how_old
    "This vehicle is #{age} years old."
  end
  
  private
  
  def age
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

class MyTruck < Vehicle     
  include Haulable
  
  NUMBER_OF_DOORS = 2
end


truck = MyTruck.new(2012, "silver", "Silverado")
car   = MyCar.new(2011, "red", "Prius")



class Student
  attr_accessor :name
  attr_writer :grade
  
  def initialize(name, grade)
    self.name = name
    self.grade = grade
  end
  
  def better_grade_than?(person)
    grade > person.grade
  end
  
  private
  
  def grade
    @grade
  end
end
    

joe = Student.new("Joe", 99)
bob = Student.new("Bob", 83)

p joe.better_grade_than?(bob)





# Vehicle.count

# puts truck.to_s
# puts car.to_s

# puts truck.how_old

# note: they stored all the attr_ methods in the superclass
# note: subclasses default to the superclass' initialize method if there is none present within the subclass
# note: what is the conventional order for class organization? attr, class var, instance var, etc...

