require 'yaml'
RPS = YAML.load_file('rpsls.yml')

module Promptable
  private

  def prompt(message)
    puts "=> #{message}"
  end
end

module Continuable
  private

  def continue
    prompt RPS['enter']
    STDIN.gets
  end
end

module Clearable
  private

  def clear_screen
    system('clear')
  end
end

module Inputtable
  private

  YES = %w(y yes)

  YESNO = %w(y yes n no)

  def yes_no_loop
    answer = nil
    loop do
      answer = format_input(gets)
      break if yn?(answer)
      prompt RPS['sorry_yn']
    end
    answer
  end

  def yn?(input)
    YESNO.include?(input)
  end

  def yes?(input)
    YES.include?(input)
  end

  def format_input(input)
    input.chomp.downcase.strip
  end
end

class Move
  VALUES = %w(rock paper scissors lizard spock)
  VALUES_ABBV = %(r p s l v)

  def self.valid?(choice)
    Move::VALUES.include?(choice) || Move::VALUES_ABBV.include?(choice)
  end

  def self.abbreviation_conversion(choice)
    case choice
    when 'r' then 'rock'
    when 'p' then 'paper'
    when 's' then 'scissors'
    when 'l' then 'lizard'
    when 'v' then 'spock'
    else          choice
    end
  end

  def self.create(choice)
    case choice
    when 'rock'     then Rock.new(choice)
    when 'paper'    then Paper.new(choice)
    when 'scissors' then Scissors.new(choice)
    when 'lizard'   then Lizard.new(choice)
    when 'spock'    then Spock.new(choice)
    end
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def to_s
    @value
  end

  private

  def initialize(value)
    @value = value
  end
end

class Rock < Move
  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end
end

class Paper < Move
  def >(other_move)
    other_move.rock? || other_move.spock?
  end
end

class Scissors < Move
  def >(other_move)
    other_move.paper? || other_move.lizard?
  end
end

class Lizard < Move
  def >(other_move)
    other_move.spock? || other_move.paper?
  end
end

class Spock < Move
  def >(other_move)
    other_move.rock? || other_move.scissors?
  end
end

class Player
  include Inputtable
  include Promptable

  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end

  def move_summary
    "#{name} chose #{move}"
  end
end

class Human < Player
  def choose
    choice = nil
    loop do
      prompt RPS['make_choice']
      choice = format_input(gets)
      break if Move.valid?(choice)
      prompt RPS['invalid']
    end
    choice = Move.abbreviation_conversion(choice)
    self.move = Move.create(choice)
  end

  private

  def set_name
    n = ''
    loop do
      prompt RPS['name']
      n = gets.chomp.strip
      break unless n.empty?
      prompt RPS['sorry_name']
    end
    self.name = n
  end
end

class Computer < Player
  ROBOTS = ['R2D2', 'C3PO', 'Big O', 'Ultimate Mechamaru', 'Exo']

  def self.generate_personality
    personality = ROBOTS.sample

    case personality
    when 'R2D2'               then R2D2.new
    when 'C3PO'               then C3PO.new
    when 'Big O'              then BigO.new
    when 'Ultimate Mechamaru' then UltimateMechamaru.new
    when 'Exo'                then Exo.new
    end
  end

  private

  def set_name
    self.name = self.class.to_s
  end
end

class R2D2 < Computer
  def choose
    move = Move::VALUES[0]
    self.move = Move.create(move)
  end
end

class C3PO < Computer
  def choose
    dice_roll = rand(6)
    move = case dice_roll
           when (1...3) then Move::VALUES[2]
           when (3..5)  then Move::VALUES[1]
           else              Move::VALUES[0]
           end

    self.move = Move.create(move)
  end
end

class BigO < Computer
  def choose
    pool = Move::VALUES
    move = [pool[0], pool[4]].sample
    self.move = Move.create(move)
  end

  private

  def set_name
    self.name = 'Big O'
  end
end

class UltimateMechamaru < Computer
  def choose
    potential_moves = []
    4.times { |_| potential_moves << Move::VALUES[3] }
    potential_moves << Move::VALUES[2]
    move = potential_moves.sample
    self.move = Move.create(move)
  end

  private

  def set_name
    self.name = 'Ultimate Mechamaru'
  end
end

class Exo < Computer
  def choose
    move = Move::VALUES.sample
    self.move = Move.create(move)
  end
end

class RPSGame
  include Clearable
  include Continuable
  include Inputtable
  include Promptable

  attr_accessor :human, :computer, :round, :winner, :history, :game_won

  MAX_SCORE = 2

  def initialize
    clear_screen
    @human = Human.new
    @computer = Computer.generate_personality
    @winner = nil
    @history = {}
    @round = 0
    @game_won = false
  end

  def play
    display_welcome_messages
    loop do
      update_gamestate
      display_history
      choose_moves
      process_moves
      display_outcomes
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  def display_welcome_messages
    prompt "#{RPS['welcome']} #{MAX_SCORE} #{RPS['wins_needed']}"
    prompt RPS['view_rules']
    answer = yes_no_loop

    if yes?(answer)
      view_rules
    else
      prompt RPS['no_time']
      continue
    end
  end

  def view_rules
    clear_screen
    prompt RPS['rules']
    prompt RPS['good_luck']
    continue
  end

  def update_gamestate
    clear_screen

    if game_won
      reset_history
      reset_score
      reset_opponent
    end

    update_round
    reset_winner
    reset_game_won
  end

  def game_won_check
    self.game_won = [human, computer].any? { |pc| pc.score == MAX_SCORE }
  end

  def reset_history
    self.history = {}
  end

  def update_round
    game_won ? self.round = 1 : self.round += 1
  end

  def reset_winner
    self.winner = nil
  end

  def reset_score
    players = [human, computer]
    players.each { |player| player.score = 0 }
  end

  def reset_opponent
    self.computer = Computer.generate_personality
  end

  def reset_game_won
    self.game_won = false
  end

  def display_history
    return unless !history.empty?
    prompt RPS['history']
    prompt RPS['history_divider']
    history.each do |round, moves|
      prompt "Round #{round}: #{moves.join(', ')}"
    end
    prompt RPS['history_divider']
    continue
    clear_screen
  end

  def choose_moves
    human.choose
    computer.choose
    update_history
  end

  def update_history
    history[self.round] = [human.move_summary, computer.move_summary]
  end

  def process_moves
    find_winner
    update_scores
    game_won_check
  end

  def find_winner
    if human.move > computer.move
      self.winner = human
    elsif computer.move > human.move
      self.winner = computer
    end
  end

  def update_scores
    winner.score += 1 unless winner.nil?
  end

  def display_outcomes
    display_moves
    display_winner
    display_scores
  end

  def display_moves
    prompt "#{human.move_summary}."
    prompt RPS['move_divider']
    prompt "#{computer.move_summary}."
    prompt RPS['move_divider']
  end

  def display_winner
    if winner.nil?
      prompt RPS['tie']
    elsif game_won
      prompt "#{winner.name}#{RPS['congrats']}#{winner.name}!"
    else
      prompt "#{winner.name}#{RPS['won_round']}"
    end
  end

  def display_scores
    return if winner.nil? || winner.score == MAX_SCORE
    prompt "#{human.name}'s score is #{human.score}. "\
           "#{computer.name}'s score is #{computer.score}."
  end

  def play_again?
    game_won ? (prompt RPS['new']) : (prompt RPS['again'])
    yes?(yes_no_loop)
  end

  def display_goodbye_message
    clear_screen
    prompt RPS['thanks']
    continue
  end
end

RPSGame.new.play
