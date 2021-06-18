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
