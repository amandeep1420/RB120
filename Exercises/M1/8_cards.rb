# class Array
#   def min
#     lowest_ranked = []
#     Card::RANK_ORDER.each do |rank|
#       lowest_ranked = self.select { |card| card.rank == rank}
#       return lowest_ranked.first if !lowest_ranked.empty?
#     end
#   end
  
#   def max
#     lowest_ranked = []
#     Card::RANK_ORDER.reverse.each do |rank|
#       lowest_ranked = self.select { |card| card.rank == rank}
#       return lowest_ranked.first if !lowest_ranked.empty?
#     end
#   end
  
#   def self.my_abilities
#     puts self.methods
#   end
# end
  

class Card
  include Comparable
  attr_reader :rank, :suit
  
  RANK_ORDER = (2..10).to_a + %w(Jack Queen King Ace)

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def to_s
    "#{rank} of #{suit}"
  end

  def value
    RANK_ORDER.index(rank)
  end
  
  def <=>(other_card)
    value <=> other_card.value
  end
end

cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
         
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
        Card.new(4, 'Diamonds'),
        Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
        Card.new('Jack', 'Diamonds'),
        Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
        Card.new(8, 'Clubs'),
        Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8
