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
  NUMS = (2..10).to_a
  FACES = %w(Ace Jack Queen King)
  VALUES = NUMS + FACES
  
  def initialize(suit, value)
    @suit = suit
    @value = value
    @dealt = false
  end
  
  def to_s
    if value == 'Ace' || value == 8
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
      prior_to_last = hand[0..-2].join(", ")
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
      not_aces_total += (not_aces_total + 11 > 21 ? 1 : 11)
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
    return unless total > Handable::MAX_HAND_TOTAL
    self.busted = true
  end
end
  
class Human < Player
  HIT = %w(h hit)
  STAY = %w(s stay)
  
  def turn(deck)
    loop do
      if human_hits?
        hit(deck)
        total_hand
        bust_check
        break if busted
      else
        stay
        break
      end
    end
  end
  
  def human_hits?
    clear
    prompt "#{TXT['human_total']} #{total}."
    space
    prompt TXT['decision']
    HIT.include?(hit_or_stay_decision)
  end
  
  def hit_or_stay_decision
    choice = nil
    loop do
      choice = format_input(gets)
      break if [HIT, STAY].any? { |inputs| inputs.include?(choice) }
      prompt TXT['invalid_hs']
    end
    choice
  end
  
  def hit(deck)
    clear
    prompt "You #{TXT['hit']}."
    deck.deal(self)
    space
    prompt "You were dealt #{hand.last}."
    continue
  end
  
  def stay
    clear
    prompt "You #{TXT['stay']}."
    space
    prompt "#{TXT['final_total']} #{total}."
    continue
  end
end

class Dealer < Player
  MIN_HAND_TOTAL = 17
  
  def turn(deck)
    clear
    prompt "#{TXT['dealer_turn']} #{MIN_HAND_TOTAL}."
    hit(deck)
  end
  
  def hit(deck)
    until total >= MIN_HAND_TOTAL
      deck.deal(self) 
      total_hand
    end
    bust_check
  end
end
  
class TwentyOneGame
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
      player_turns
      puts return_winner
      break
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
    continue
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
    clear
    prompt TXT['first_deal']
    space
    prompt "#{TXT['human_has']} #{human.join_hand}."
    space
    prompt "#{TXT['revealed_card']} #{dealer.hand.sample}."
    space
    continue
  end
  
  def player_turns
    human.turn(deck)
    return if human.busted
    dealer.turn(deck)
  end
  
  def display_winner
    case return_winner
    when :dealer then prompt TXT['dealer_won']
    when :player then prompt TXT['player_won']
    when :tie    then prompt TXT['tie']
    end
  end
  
  def return_winner
    case
    when human.busted || dealer.total > human.total  then :dealer
    when dealer.busted || human.total > dealer.total then :human
    else                                                  :tie
    end
  end
    
end

game = TwentyOneGame.new
game.start
