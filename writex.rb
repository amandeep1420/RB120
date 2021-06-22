# classes, objects

class Dog
end

buster = Dog.new


# attr_* to create setters and getters
#reader
class Dog
  attr_reader :leg_count
  
  def initialize(leg_count)
    @leg_count = leg_count
  end
end

class Dog
  def initialize(leg_count)
    @leg_count = leg_count
  end
  
  def leg_count
    @leg_count
  end
end

#writer
class Dog
  attr_writer :leg_count
  
  def initialize(leg_count)
    @leg_count = leg_count
  end
end

class Dog
  def initialize(leg_count)
    @leg_count = leg_count
  end
  
  def leg_count=(count)
    @leg_count = count
  end
end

#accessor
class Dog
  attr_accessor :leg_count
  
  def initialize(leg_count)
    @leg_count = leg_count
  end
end

class Dog
  def initialize(leg_count)
    @leg_count = leg_count
  end
  
  def leg_count
    @leg_count
  end
  
  def leg_count=(count)
    @leg_count = count
  end
end


#call setter/getter
class Dog
  attr_accessor :color
  
  def initialize(color)
    @color = color
  end
end

sparky = Dog.new('brown')

sparky.color           #=> 'brown'
sparky.color = 'black' #=> 'black'
sparky.color           #=> 'black'

#instance vs. class
class Dog
  def self.what_are_dogs
    puts "Dogs are the best!"
  end
  
  def running
    puts "I'm running!"
  end
end

Dog.what_are_dogs    #=> Dogs are the best!
Dog.running          #=> NoMethodError - undefined method 'running' for Dog:Class

sparky = Dog.new
sparky.running       #=> I'm running!
sparky.what_are_dogs #=> NoMethodError - undefined method 'what_are_dogs' for #<Dog...memory address>


#method access control
class Dog
  def initialize(color)
    @color = color
  end
  
  def color
    @color
  end
end

sparky = Dog.new('brown')
sparky.color #=> 'brown'

#privatizing...
class Dog
  def initialize(color)
    @color = color
  end
  
  private
  
  def color
    @color
  end
end

sparky = Dog.new('brown')
sparky.color #=> NoMethodError - private method 'color' called for <#Dog:...memory address>

#privatizing but using as private method in public method
class Dog
  def initialize(color)
    @color = color
  end
  
  def tell_color
    puts "My color is #{color}!"
  end
  
  private
  
  def color
    @color
  end
end

sparky = Dog.new('brown')
sparky.color #=> My color is brown!

#protected - allows us to call method on other instance of the same class
#act like private methods outside of classs
#allow us to call method on other instance of same class within the class
class Dog
  def initialize(color)
    @color = color
  end
  
  def compare_colors(other_dog)
    color == other_dog.color
  end
  
  protected #can't call outside of class, but can call on other class object 
            #change to private and compare_colors will no longer function, pops error about argument invoking private method
  def color
    @color
  end
end


#referencing instance vars vs. setters and getters
# getters
# -----------------------------------------------------
#this getter exposes sensitive data
class CreditCard
  def initialize(number)
    @number = number
  end
  
  def number
    @number
  end
end

#full card number now exposed
amex = CreditCard.new(5555555555551234)
amex.number #=> 5555555555551234

#this getter formats sensitive data to relay specifically what is desired by programmer
class CreditCard
  def initialize(number)
    @number = number
  end
  
  def number
    last_four = @number.to_s.split('')[-4..-1].join
    ('X' * 12) + last_four
  end
end

#only last four digits are now exposed
amex = CreditCard.new(5555555555551234)
amex.number #=> XXXXXXXXXXXX1234

#setters
# -----------------------------------------------------
#this setter allows instance variable to be reassigned to anything
class Dog
  def initialize(color)
    @color = color
  end
  
  def what_is_my_color
    puts "My color is #{@color}!"
  end
  
  def color=(color)
    @color = color
  end
end

#it is now possible to reassign the color attribute for an instance of Dog to something that doesn't necessarily make sense
sparky = Dog.new('brown')
sparky.color = 'Matz'   #=> 'Matz'
sparky.what_is_my_color #=> My color is Matz!

#this setter allows us to validate input before reassignment
class Dog
  VALID_COLORS = ['brown', 'black', 'merle', 'white', 'yellow']
  def initialize(color)
    @color = color
  end
  
  def what_is_my_color
    puts "My color is #{@color}!"
  end
  
  def color=(color)
    VALID_COLORS.include?(color) ? (@color = color) : (puts "Invalid color!")
  end
end

#it is no longer possible to reassign the color attribute unless the input passes our validation code
sparky = Dog.new('brown')
sparky.color = 'Matz'    #=> Invalid color!
sparky.what_is_my_color  #=> My color is brown!
sparky.color = 'merle'   #=> 'merle'
sparky.what_is_my_color  #=> My color is merle!


#encapsulation
#data protection
class Employee
  def initialize(name)
    @name      = name
    @passcode  = (1111..9999).to_a.sample
  end
  
  def valid_passcode?
    passcode != nil
  end
  
  private
  
  attr_accessor :passcode
  
end

# here, new employees are assigned a random passcode, and the passcode itself is never exposed to the rest of the code base/the user
# but we can still use it
bob = Employee.new("Bob")
bob.valid_passcode #=> true
bob.passcode       #=> NoMethodError - private method 'passcode' called for (memory address)

#exposing desired behaviors/interfaces
class Employee
  def initialize(name)
    @name      = name
    @passcode  = (1111..9999).to_a.sample
  end
  
  def new_passcode
    generate_new_passcode
    puts "A new passcode has been assigned to #{@name}!"
  end
  
  private
  
  attr_accessor :passcode
  
  def generate_new_passcode
    loop do
      new_passcode = (1111..9999).to_a.sample
      break if passcode != new_passcode
    end
    @passcode = new_passcode
  end
end

#here, we are able to make new passcodes for employees without needing to know the logic behind the process or exposing unnecessary behaviors
bob = Employee.new('Bob')
bob.new_passcode           #=> A new passcode has been assigned to Bob!
bob.passcode               #=> NoMethodError - private method
bob.generate_new_passcode  #=> NoMethodError - private method 


#polymorphism - two "chief" ways to employ it: inheritance (with overriding as sub-type) and duck-typing
#--------------
#via inheritance
class Athlete
  def warm_up
    puts "I'm going to warm up with some stretches!"
  end
end

class Runner < Athlete
end

class Calisthenist < Athlete
end

# even though we have different classes/"types" of objects, they respond to the same interface
# via inheritance from a superclass
Athlete.new.warm_up      #=> I'm going to warm up with some stretches!
Runner.new.warm_up       #=> I'm going to warm up with some stretches!
Calisthenist.new.warm_up #=> I'm going to warm up with some stretches!

#via overriding
class Athlete
  def warm_up
    puts "I'm going to warm up with some stretches!"
  end
end

class Judoka < Athlete
  def warm_up
    puts "I'm going to do some light randori with a partner!"
  end
end

class Swimmer < Athlete
  def warm_up
    puts "I'm going to take a few easy laps!"
  end
end

#we have different classes/"types" of objects that respond to the same interface;
#however, we have overriden it with one specific to each class
#distinct from duck typing as class inheritance is still a factor
#***think of overriding as a subtype of polymorphism through inheritance***

Athlete.new.warm_up #=> I'm going to warm up with some stretches!
Judoka.new.warm_up  #=> I'm going to do some light randori with a partner!
Swimmer.new.warm_up #=> I'm going to take a few easy laps!

#via duck-typing
class Judoka
  def start_match
    find_opponent
    walk_on_to_mat
    bow_to_opponent
    start_fighting
  end
end

class Referee
  def start_match
    reset_scorecard
    welcome_judokas
    say_hajime
  end
end

class JudoClub
  def start_match
    quiet_down
    everyone_takes_a_seat
    everyone_pays_attention
  end
end

#no inheritance involved/classes are distinct, but instances of each class
#respond to the same interface. polymorphism via duck-typing should be intentionally designed, not occur by happenstance;
#these example classes are concerned with the same problem domain, so it makes sense;
#creating a Fridge class and a Runner class that both respond to a #run method call, however, would probably not make sense in most scenarios
JudoClub.new.start_match #=> able to respond to start_match
Referee.new.start_match  #=> able to respond to start_match
Judoka.new.start_match   #=> able to respond to start_match

#fake operators
#equality
#truthiness

#collaborator objects

