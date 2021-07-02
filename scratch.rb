class Human
  def initialize
    @diet = "food"
    @limbs = 4
    @needs = ['air', 'water', 'shelter']
  end
end

class Hand
  def initialize
    @cards = []
  end
  
  def cards
    @cards
  end
end

class Card; end
  
hand = Hand.new

p hand.cards

hand.cards << Card.new
hand.cards << Card.new
hand.cards << Card.new

p hand.cards