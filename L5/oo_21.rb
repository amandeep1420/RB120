require 'yaml'
TXT = YAML.load_file('oo_21_yaml.yml')

module Interactable
  private

  YES   = %w(y yes)
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

  def yes?(input)
    YES.include?(input)
  end

  def yes_no_loop
    answer = nil
    loop do
      answer = format_input(gets)
      break if yn?(answer)
      prompt TXT['sorry_yn']
    end
    answer
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

  def deal(hand)
    card = nil

    loop do
      card = cards.sample
      break if card.dealt == false
    end

    card.dealt = true
    hand << card
  end

  def deal_initial_hand(hand)
    2.times { deal(hand) }
  end

  private

  def generate_deck
    cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards
  end
end

class Card
  attr_accessor :dealt, :suit, :value

  SUITS  = %w(Clubs Hearts Diamonds Spades)
  NUMS   = (2..10).to_a
  FACES  = %w(Ace Jack Queen King)
  VALUES = NUMS + FACES

  private

  def initialize(suit, value)
    @suit  = suit
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

  private

  def add_cards(cards)
    cards.map do |card|
      card.value == card.value.to_s.to_i ? card.value : 10
    end.sum
  end

  def add_aces(not_aces_total, aces_count)
    loop do
      break if aces_count == 0
      not_aces_total += (not_aces_total + 11 > MAX_HAND_TOTAL ? 1 : 11)
      aces_count -= 1
    end
    not_aces_total
  end
end

class Player
  include Handable
  include Interactable

  attr_accessor :busted, :points

  def initialize
    @hand   = []
    @total  = 0
    @busted = false
    @points = 0
  end

  def bust_check
    return unless total > Handable::MAX_HAND_TOTAL
    self.busted = true
  end

  def reset_points
    self.points = 0
  end

  def reset_hand_and_bust_status
    self.hand   = []
    self.busted = false
  end
end

class Human < Player
  HIT = %w(h hit)
  STAY = %w(s stay)

  attr_reader :name

  def initialize
    super()
    ask_name
  end

  def final_summary
    prompt "#{TXT['human_has']} #{join_hand}."
    prompt "#{TXT['human_final_total']} #{total}."
  end

  def turn(deck)
    clear
    prompt TXT['your_turn']
    space
    hit_loop(deck)
  end

  private

  def ask_name
    clear
    prompt TXT['name']
    name = ''
    loop do
      name = format_input(gets)
      break unless name.empty?
      prompt TXT['name_please']
    end
    @name = name
  end

  def hit_loop(deck)
    loop do
      if human_hits?
        hit(deck)
        break if busted
      else
        stayed
        break
      end
    end
  end

  def human_hits?
    clear
    prompt "#{TXT['human_total']} #{total}."
    prompt TXT['decision']
    choice = nil
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
    deck.deal(hand)
    total_hand
    prompt "You were dealt #{hand.last}."
    bust_check
    space
    continue
  end

  def stayed
    clear
    prompt "You #{TXT['stay']}."
    prompt "#{TXT['human_final_total']} #{total}."
    space
    continue
  end
end

class Dealer < Player
  MIN_HAND_TOTAL = 17
  PROMPT_KEYS = [:sneaky, :honest, :lazy, :goofy, :anime]

  def turn(deck)
    clear
    prompt "#{TXT['dealer_turn']} #{MIN_HAND_TOTAL}."
    space
    puts TXT['dealer_prompts'][pick_story]
    space
    continue
    hit(deck)
  end

  def final_summary
    prompt "#{TXT['dealer_has']} #{join_hand}."
    prompt "#{TXT['dealer_final_total']} #{total}."
  end

  private

  def pick_story
    PROMPT_KEYS.sample.to_s
  end

  def hit(deck)
    until total >= MIN_HAND_TOTAL
      deck.deal(hand)
      total_hand
    end
    bust_check
  end
end

class TwentyOneGame
  include Interactable

  POINTS_TO_WIN_GAME = 2

  def initialize
    @deck           = Deck.new
    @human          = Human.new
    @dealer         = Dealer.new
    @winner         = nil
    @round          = 1
    @game_completed = false
  end

  def start
    welcome_player
    main_game
    goodbye_player
  end

  private

  attr_accessor :deck, :game_completed, :round, :winner
  attr_reader   :dealer, :human

  def welcome_player
    clear
    prompt "#{TXT['greeting']} #{human.name}!"
    prompt "#{POINTS_TO_WIN_GAME} #{TXT['points_to_win']}."
    space
    explain_game if view_rules?
  end

  def view_rules?
    prompt TXT['view_rules']
    yes?(yes_no_loop)
  end

  def explain_game
    clear
    puts TXT['rules']
    space
    continue
  end

  def main_game
    loop do
      recap
      first_deal
      player_turns
      conclude_round
      break unless play_again?
      reset
    end
  end

  def recap
    return unless round > 1
    clear
    prompt TXT['recap']
    space
    points_summary
    space
    prompt "#{TXT['round']} #{round}!"
    continue
  end

  def points_summary
    prompt "#{TXT['human_points']} #{human.points}"
    space
    prompt "#{TXT['dealer_points']} #{dealer.points}"
  end

  def first_deal
    deal_initial_hands
    total_initial_hands
    show_initial_hands
  end

  def deal_initial_hands
    clear
    deck.deal_initial_hand(human.hand)
    deck.deal_initial_hand(dealer.hand)
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

  def player_turns
    human.turn(deck)
    return if human.busted
    dealer.turn(deck)
  end

  def conclude_round
    display_final_hands
    space
    find_round_winner
    update_player_points
    game_completed_check
    display_round_winner
    increment_round
    space
    continue
  end

  def display_final_hands
    clear
    prompt TXT['concluded']
    space
    human.final_summary
    space
    dealer.final_summary
  end

  def find_round_winner
    if human.busted
      self.winner = dealer
    elsif dealer.busted
      self.winner = human
    elsif dealer.total > human.total
      self.winner = dealer
    elsif human.total > dealer.total
      self.winner = human
    end
  end

  def update_player_points
    human.points += 1 if winner == human
    dealer.points += 1 if winner == dealer
  end

  def game_completed_check
    players = [human, dealer]
    return unless players.any? { |player| player.points == POINTS_TO_WIN_GAME }
    self.game_completed = true
  end

  def display_round_winner
    case winner
    when dealer
      result = human.busted ? TXT['human_busted'] : TXT['dealer_won']
      prompt result
    when human
      result = dealer.busted ? TXT['dealer_busted'] : TXT['human_won']
      prompt result
    when nil
      prompt TXT['tie']
    end
  end

  def increment_round
    self.round += 1
  end

  def play_again?
    clear
    if game_completed
      display_game_winner
      space
    end
    prompt(game_completed ? TXT['another_game'] : TXT['another_round'])
    yes?(yes_no_loop)
  end

  def display_game_winner
    game_winner = [human, dealer].select do |player|
                    player.points == POINTS_TO_WIN_GAME
                  end[0]

    if game_winner == dealer
      prompt TXT["dealer_won_game"]
    else
      prompt "#{human.name} #{TXT['human_won_game']}"
    end
  end

  def goodbye_player
    clear
    prompt "#{TXT['goodbye']} #{human.name}!"
  end

  def reset
    clear
    reset_gamestate if game_completed

    reset_hands_and_bust_statuses
    reset_deck
  end

  def reset_gamestate
    reset_points
    self.round = 1
    self.game_completed = false
  end

  def reset_points
    human.reset_points
    dealer.reset_points
  end

  def reset_hands_and_bust_statuses
    human.reset_hand_and_bust_status
    dealer.reset_hand_and_bust_status
  end

  def reset_winner
    self.winner = nil
  end

  def reset_deck
    self.deck = Deck.new
  end
end

game = TwentyOneGame.new
game.start
