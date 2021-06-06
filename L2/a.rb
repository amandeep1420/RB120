class Cat
  def initialize
    @species = 'cat'
    @legs = 4
    @eyes = 2
    @temperament = 'butthole'
    @food = 'fishies'
  end
  
  def food=(item)
    @food = item
  end
  
  def food
    @food
  end
end

toby = Cat.new

p toby.food

toby.food = 'treats'

p toby.food
