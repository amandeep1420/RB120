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