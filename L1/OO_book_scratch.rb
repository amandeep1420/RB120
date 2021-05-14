class GoodDog
end

class HumanBeing
end

sparky = GoodDog.new

bob = HumanBeing.new

module Speak
  def speak(sound)
    puts sound
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

sparky.speak('meow')
bob.speak('heh')

puts "--GoodDog ancestors--"
puts GoodDog.ancestors
puts "--HumanBeing ancestors--"
puts HumanBeing.ancestors


=begin
How do we create an object in Ruby? Give an example of the creation of an object.

String.new
Integer.new
Array.new

We use the new instance method?

Not quite. We create an object by defining a class and instantiating it by using
the `new` method to crate an instance, also known as an object.

class BigGuy
end

jeff = BigGuy.new
=end

=begin
What is a module? What is its purpose? 
How do we use them with our classes? 
Create a module for the class you created in exercise 1 and include it properly.

A module allows a class to access various methods via 'mixing-in'...
You use them with a class by 'calling' (?) a class, using the include method with the module

A module allows us to group reusable code into one place; we use modules in our classes by using the 
`include` method invocation, followed by the module name. Modules are also used as a namespace....

...you can create new classes within modules; this allows you to organize them.
When 
=end


module Height
  def height(feet)
    puts feet
  end
end

module Careers
  class Engineer
  end
  
  class Teacher
  end
end

class BigGuy
  include Height
end

jeff = BigGuy.new

jeff.height(6)

jeff_upgrade = Careers::Engineer.new

