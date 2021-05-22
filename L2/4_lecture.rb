class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

class Cat < Pet; end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"


# MAC is the order in which Ruby traverses the class hierarchy in order to locate a method to invoke during a method invocation.
# ruby starts with the class of the caller itself, then included modules from bottom to top; if nothing is found, it proceeds to check the 
# superclass of the of the calling object's class, ad infinitum, until either a method is found with the specified name or the end of the path is reached








class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    #implementation
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    #implementation
  end
end











