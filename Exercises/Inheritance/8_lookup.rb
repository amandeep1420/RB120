class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color

# the difference was that they listed the stopping point; in the prior exercise
# the Animal superclass contained a color method, so only Cat and Animal were listed
# here, they listed the entire lookup path returned by ancestors all the way back to BasicObject