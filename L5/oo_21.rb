# Twenty-one is a card game consisting of a dealer and a player, where the participants
# try to get as close to 21 as possible with their hand total without going over.

=begin
Game overview:
- both participants are initially dealt 2 cards from a 52-card deck
- the player takes the first turn, and can 'hit' or 'stay'
  - if the player busts, he loses
  - if the player stays, it's the dealer's turn
- the dealer takes the second turn, and must hit until his hand total >= 17
  - if the dealer busts, he loses
  - if the dealer stays, the turn phase is over
- if nobody has busted, then the player with the highest hand total wins
  - if both totals are equal, then it's a tie and nobody wins

Nouns: card, player, dealer, participant, deck, game, total
Verbs: deal, hit, stay, busts

The "total" is obviously not going to be a class, but is actually an attribute within 
a class. In other words, it's not a noun that performs actions, but a property of 
some other noun. You can also think of it as a verb: "calculate_total".

Another thing to note: the verb "busts" is not an action anyone is performing.
Rather, it's a state -- is the player/dealer 'busted'?

Let's write out the classes and organize the verbs.

Player
- hit
- stay
- busted?
- total
Dealer
- hit
- stay
- busted?
- total
- deal (should this be here, or in Deck?)
Participant
Deck
- deal (should this be here, or in Dealer?)
Card
Game
- start

First thing to notice is the overlap with the Player and Dealer classes.
A natural place to extract that overlap is a superclass -- perhaps Participant?
In their ref. implementation, they use a module called Hand to capture this, but
this isn't the only way; we can extract to a superclass if desired.

Spike is below
=end

# class Player
#   def initialize
#     # what would the "data" or "states" of a Player object entail?
#     # maybe cards? a name?
#   end
  
#   def hit; end
    
#   def stay; end
    
#   def busted?; end
  
#   def total
#     # definitely looks like we need to know about "cards" to produce some total
#   end
# end

# class Dealer
#   # this looks basically the same as player...how do we handle this?
# end

# class Participant
#   # what goes here? maybe the shared behaviors of Player and Dealer?
# end

# class Deck
#   def initialize
#     # we need a structure to track cards...hash, array, something else?
#   end
  
#   def deal
#     # does the deck deal, or the dealer?
#   end
# end

# class Card
#   def initialize
#     # what are the "states" of a card? interesting...
#   end
# end

=begin
This is obviously just a skeleton and lots of details still need to be fleshed out.
Let's try taking a stab at Game#start - that will drive our implementation of 
our other classes.

We'll start by writing things we wished existed. See below.
=end

require 'yaml'
TXT = YAML.load_file('oo_21_yaml.yml')

module Interactable
  
  private

  YES = %w(y yes)
  YESNO = %w(y yes n no)
  
  def clear
    system 'clear'
  end

  def continue
    prompt TXT['continue']
    STDIN.gets
  end
  
  def format_input(input)
    input.chomp.downcase.strip
  end
  
  def prompt(string)
    puts "=> #{string}"
  end
  
  def space
    puts ""
  end

  def yes_no_loop
    answer = nil
    loop do
      answer = format_input(gets)
      break if yn?(answer)
      prompt RPS['sorry_yn']
    end
    answer
  end
  
  def yes?(input)
    YES.include?(input)
  end

  def yn?(input)
    YESNO.include?(input)
  end
end

class Deck
  attr_accessor :cards
  
  def initialize
    @cards = generate_deck
  end
  
  def generate_deck
    cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards
  end
  
  def deal(player)
    card = nil
    
    loop do
      card = cards.sample
      break if card.dealt == false
    end
    
    card.dealt = true
    player.hand << card
  end
  
  def deal_initial_hand(player)
    2.times { deal(player) }
  end
end

class Card
  attr_reader :suit, :value
  attr_accessor :dealt
  
  SUITS = %w(Clubs Hearts Diamonds Spades)
  NUMS = (1..10).to_a
  FACES = %w(Ace Jack Queen King)
  VALUES = NUMS + FACES
  
  def initialize(suit, value)
    @suit = suit
    @value = value
    @dealt = false
  end
  
  def to_s
    if value == 'Ace' || value == '8'
      "an #{value} of #{suit}"
    else
      "a #{value} of #{suit}"
    end
  end
end

module Handable
  attr_accessor :hand, :total  
  
  MAX_HAND_TOTAL = 21
  
  def join_hand
    case hand.size
    when 2 then hand.join(" and ")
    else        
      prior_to_last = hand[0..-2].join(",")
      last = ", and #{hand[-1]}"
      prior_to_last + last
    end
  end
  
  def total_hand
    aces, not_aces = hand.partition { |card| card.value == 'Ace' }
    
    not_aces_total = add_cards(not_aces)
    
    aces_count = aces.size
    
    self.total = add_aces(not_aces_total, aces_count)
  end
  
  def add_cards(cards)
    cards.map do |card| 
      card.value == card.value.to_s.to_i ? card.value : 10
    end.sum
  end
  
  def add_aces(not_aces_total, aces_count)
    loop do
      break if aces_count == 0
      ((not_aces_total + 11) > 21) ? not_aces_total += 1 : not_aces_total += 11
      aces_count -= 1
    end
    not_aces_total
  end
end

class Player
  include Handable
  include Interactable
  
  attr_accessor :busted
  
  def initialize
    @hand = []
    @total = 0
    @busted = false
  end
  
  def bust_check
    if total > Handable::MAX_HAND_TOTAL
      self.busted = true
    end
  end
end
  
class Human < Player
  HIT = %w(h hit)
  STAY = %w(s stay)
  
  def turn(deck)
    loop do
      if human_hits?
        hit(deck)
        break if busted
      else
        stay
        break
      end
    end
  end
  
  def human_hits?
    choice = nil
    clear
    prompt "#{TXT['human_total']} #{total}."
    space
    prompt TXT['decision']
    loop do
      choice = format_input(gets)
      break if [HIT, STAY].any? { |inputs| inputs.include?(choice) }
      prompt TXT['invalid_hs']
    end
    HIT.include?(choice)
  end
  
  def hit(deck)
    clear
    prompt "You #{TXT['hit']}."
    deck.deal(self)
    space
    prompt "You were dealt #{hand.last}."
    continue
    total_hand
    bust_check
  end
  
  def stay
    clear
    prompt "You #{TXT['stay']}."
    space
    prompt "#{TXT['human_total']} #{total}."
  end
end

class Dealer < Player; end
  
class Game
  include Interactable
  
  attr_accessor :deck, :human, :dealer
  
  def initialize
    @deck = Deck.new
    @human = Human.new
    @dealer = Dealer.new
  end
  
  def start
    greeting
    # ask_name
    loop do
      first_deal
      human.turn(deck)
      break
      # show_initial_hands
      # player_turn
      # dealer_turn
      # show_result
      # play_again?
    end
    # closing
  end
  
  private
    
  def greeting
    clear
    prompt TXT['greeting']
    space
  end
  
  def first_deal
    deal_initial_hands
    total_initial_hands
    show_initial_hands
  end
  
  def deal_initial_hands
    deck.deal_initial_hand(human)
    deck.deal_initial_hand(dealer)
  end
  
  def total_initial_hands
    human.total_hand
    dealer.total_hand
  end
  
  def show_initial_hands
    prompt TXT['first_deal']
    space
    prompt "#{TXT['human_has']} #{human.join_hand}."
    space
    prompt "#{TXT['revealed_card']} #{dealer.hand.sample}."
    space
    continue
  end
end

game = Game.new
game.start
