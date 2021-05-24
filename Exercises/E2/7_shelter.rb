class Pet
  attr_reader :animal, :name
  
  def initialize(animal, name)
    @animal = animal
    @name = name
    Shelter.available_pets << self
  end
  
  def to_s
    "a #{animal} named #{name}"
  end
end

class Owner
  attr_reader :name
  attr_accessor :number_of_pets, :pets
  
  def initialize(name)
    @name = name
    @pets = []
  end
  
  def number_of_pets
    self.pets.size
  end
end

class Shelter
  @@adopters = []
  @@available_pets = []
    
  def self.available_pets
    @@available_pets
  end
  
  def self.available_pet_count
    @@available_pets.size
  end
  
  def adopt(owner, pet)
    owner.pets << @@available_pets.delete(pet)
    @@adopters << owner unless @@adopters.include?(owner)
  end
  
  def print_available_pets
    puts "The Animal Shelter has the following unadopted pets:"
    puts @@available_pets; puts "\n"
  end
  
  def print_adoptions
    @@adopters.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      puts owner.pets; puts "\n"
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

asta       = Pet.new('dog', 'Asta')
laddie     = Pet.new('dog', 'Laddie')
fluffy     = Pet.new('cat', 'Fluffy')
kat        = Pet.new('cat', 'Kat')
ben        = Pet.new('cat', 'Ben')
chatterbox = Pet.new('parakeet', 'Chatterbox')
bluebell   = Pet.new('parakeet', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
shelter.print_available_pets
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal shelter has #{Shelter.available_pet_count} unadopted pets."