class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end

class Deck
  attr_accessor :cards
  
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
  
  def initialize
    @cards = generate_shuffled_deck
  end
  
  def generate_shuffled_deck
    all_cards = []
    
    RANKS.each do |rank|
      SUITS.each do |suit|
        all_cards << Card.new(rank, suit)
      end
    end
    
    all_cards.shuffle
  end
  
  def draw
    self.cards = generate_shuffled_deck if cards.empty?
    cards.pop
  end
end

# Include Card and Deck classes from the last two exercises.

class PokerHand
  def initialize(cards)
    hand = []
    5.times { hand << cards.draw }
    @hand = hand.sort
  end

  def print
    @hand.each { |card| puts card.to_s }
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    straight_flush? && (@hand.map(&:value).minmax == [10, 14])
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    ranks_in_hand = @hand.map(&:rank)
    ranks_in_hand.each do |hand_rank|
      return true if ranks_in_hand.count(hand_rank) == 4
    end
    false
  end

  def full_house?
    counts = []
    ranks_in_hand = @hand.map(&:rank)
    ranks_in_hand.uniq.each do |hand_rank|
      counts << 3 if ranks_in_hand.count(hand_rank) == 3
      counts << 2 if ranks_in_hand.count(hand_rank) == 2
    end
    counts.sort == [2, 3]
  end

  def flush?
    check_suit = @hand[0].suit
    @hand.all? { |card| check_suit == card.suit }
  end

  def straight?
    ranks = @hand.map { |card| card.rank }
    Deck::RANKS.each_cons(5).to_a.include?(ranks)
  end

  def three_of_a_kind?
    ranks_in_hand = @hand.map(&:rank)
    ranks_in_hand.each do |hand_rank|
      return true if ranks_in_hand.count(hand_rank) == 3
    end
    false
  end

  def two_pair?
    counts = []
    ranks_in_hand = @hand.map(&:rank)
    ranks_in_hand.uniq.each do |hand_rank|
      counts << 2 if ranks_in_hand.count(hand_rank) == 2
    end
    counts == [2, 2]
  end

  def pair?
    ranks_in_hand = @hand.map(&:rank)
    ranks_in_hand.each do |hand_rank|
      return true if ranks_in_hand.count(hand_rank) == 2
    end
    false
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'