require 'yaml'
RPS = YAML.load_file('rps_yaml.yml')

require 'pry'

def prompt(message)
  puts "=> #{message}"
end

class Move
  VALUES = %w(rock paper scissors lizard spock)

  def initialize(value)
    @value = value
  end
  
  def self.convert(choice)
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
end

class Rock < Move
  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end
  
  def <(other_move)
    other_move.paper? || other_move.spock?
  end
end

class Paper < Move
  def >(other_move)
    other_move.rock? || other_move.spock?
  end
  
  def <(other_move)
    other_move.scissors? || other_move.lizard?
  end
end
  
class Scissors < Move
  def >(other_move)
    other_move.paper? || other_move.lizard?
  end
  
  def <(other_move)
    other_move.rock? || other_move.spock?
  end
end
  
class Lizard < Move
  def >(other_move)
    other_move.spock? || other_move.paper?
  end
  
  def <(other_move)
    other_move.scissors? || other_move.rock?
  end
end
  
class Spock < Move
  def >(other_move)
    other_move.rock? || other_move.scissors?
  end
  
  def <(other_move)
    other_move.lizard? || other_move.paper?
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      prompt RPS['name']
      n = gets.chomp
      break unless n.empty?
      prompt RPS['sorry_name']
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      prompt RPS['make_choice']
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      prompt RPS['invalid']
    end
    self.move = Move.convert(choice)
  end
end

class Computer < Player
  ROBOTS = ['R2D2', 'C3PO', 'Big O', 'Ultimate Mechamaru', 'Exo']

  private
  
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

  def set_name
    self.name = self.class.to_s
  end
end

class R2D2 < Computer
  def choose
    move = 'rock'
    self.move = Move.new(move)
  end
end

class C3PO < Computer
  def choose
    dice_roll = rand(6)
    move = case dice_roll
           when (1...3) then 'scissors'
           when (3..5)  then 'paper'
           else              'rock'
           end

    self.move = Move.new(move)
  end
end

class BigO < Computer
  def choose
    move = %w(spock rock).sample
    self.move = Move.new(move)
  end
  
  private
  
  def set_name
    self.name = 'Big O'
  end
end

class UltimateMechamaru < Computer
  def choose
    potential_moves = []
    10.times { |_| potential_moves << 'lizard' }
    potential_moves << 'scissors'
    move = potential_moves.sample
    self.move = Move.new(move)
  end
  
  private
  
  def set_name
    self.name = 'Ultimate Mechamaru'
  end
end

class Exo < Computer
  def choose
    move = Move::VALUES.sample
    self.move = Move.new(move)
  end
end

module GameStates
  attr_accessor :history, :game_over

  MAX_SCORE = 1
  
  private

  def update_gamestate
    clear_screen
    game_over_check
    reset_history
    update_round
    reset_winner
    reset_score
    reset_opponent
    game_over_reset
  end

  def clear_screen
    system('clear') if self.round > 1
  end

  def game_over_check
    self.game_over = [human, computer].any? do |player| 
                       player.score == MAX_SCORE
                     end
  end

  def reset_history
    if game_over
      self.history = {}
    end
  end

  def update_round
    if game_over
      self.round = 1
    else
      self.round += 1
    end
  end

  def reset_winner
    self.winner = nil
  end

  def reset_score
    players = [human, computer]
    if game_over
      players.each { |player| player.score = 0 }
    end
  end
  
  def reset_opponent
    if game_over
      self.computer = Computer.generate_personality
    end
  end
  
  def game_over_reset
    self.game_over = false
  end
end

class RPSGame
  include GameStates

  attr_accessor :human, :computer, :round, :winner

  def initialize
    @human = Human.new
    @computer = Computer.generate_personality
    @winner = nil
    @history = {}
    @round = 1
  end
  
  def play
    display_welcome_message
    loop do
      update_gamestate
      display_history
      human.choose
      computer.choose
      display_moves
      # update_history
      find_winner
      display_winner
      update_scores
      # binding.pry
      display_scores
      break unless play_again?
    end
    display_goodbye_message
  end
  
  private

  def display_welcome_message
    prompt RPS['welcome']
  end
  
  def display_history
    if !history.empty?
      prompt RPS['history']
      history.each do |round, moves|
        prompt "#{round}: #{moves}"
      end
    end
  end

  def display_moves
    prompt "#{human.name} chose #{human.move}."
    prompt "#{computer.name} chose #{computer.move}."
  end

  def find_winner
    if human.move > computer.move
      self.winner = human
    elsif human.move < computer.move
      self.winner = computer
    end
  end

  def update_scores
    self.winner.score += 1 unless self.winner == nil
  end

  def display_winner
    if self.winner == nil
      prompt RPS['tie']
    elsif self.winner.score == GameStates::MAX_SCORE
      prompt "#{winner.name}#{RPS['congrats']}#{winner.name}!"
    else
      prompt "#{winner.name}#{RPS['won_round']}"
    end
  end

  def display_scores
    prompt "#{human.name}'s score is #{human.score}."
    prompt "#{computer.name}'s score is #{computer.score}."
  end

  def play_again?
    answer = nil
    loop do
      prompt RPS['play_again']
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      prompt RPS['sorry_yn']
    end
    answer == 'y'
  end
  
  def display_goodbye_message
    prompt RPS['thanks']
  end
end

RPSGame.new.play