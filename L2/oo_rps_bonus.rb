class Move
  VALUES = %w(rock paper scissors lizard spock)

  def initialize(value)
    @value = value
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

  def self.create_subclass_object(string)
    case string
    when 'rock'     then Rock.new(string)
    when 'paper'    then Paper.new(string)
    when 'scissors' then Scissors.new(string)
    when 'lizard'   then Lizard.new(string)
    when 'spock'    then Spock.new(string)
    end
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
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a name."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid input."
    end
    self.move = Move.create_subclass_object(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(R2D2 C-3PO Big-O Ultimate-Mechamaru).sample
  end

  def choose
    move = Move::VALUES.sample
    self.move = Move.create_subclass_object(move)
  end
end

class RPSGame
  attr_accessor :human, :computer, :round, :round_winner, :grand_winner, 
                :move_history
  
  MAX_SCORE = 3
  
  def display_history
    if move_history.empty?
      nil
    else
    'something'
    end
  end

  def initialize
    @human = Human.new
    @computer = Computer.new
    @winner = nil
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end
  
  def find_winner
    if human.move > computer.move
      self.round_winner = human
    elsif human.move < computer.move
      self.round_winner = computer
    end
  end
    
  def update_scores
    self.round_winner.score += 1 unless self.round_winner == nil
  end

  def display_winner
    winner = self.round_winner 
    if winner == nil
      puts "It's a tie!"
    else
      winner.score == MAX_SCORE ? (puts "#{winner.name} won the game! Congratulations, #{winner.name}!") : (puts "#{winner.name} won this round!") 
    end
  end
  
  def display_scores
    puts "#{human.name}'s score is #{human.score}."
    puts "#{computer.name}'s score is #{computer.score}."
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n."
    end
    return false if answer == 'n'
    return true if answer == 'y'
  end
  
  def update_gamestate
    reset_history
    update_round
    reset_winner
  end
  
  def reset_history
    if max_reached?
      self.move_history = {}
    end
  end
  
  def max_reached?
    players = [human, computer]
    players.any? { |player| player.score == MAX_SCORE }
  end
  
  def reset_winner
    self.round_winner = nil
    players = [human, computer]
    if max_reached?
      players.each { |player| player.score = 0 }
    end
  end
  
  def increment_round
    if max_reached?
      self.round = 0
    else
      self.round += 1
    end
  end

  def play
    display_welcome_message
    loop do
      update_gamestate
      display_history
      human.choose
      computer.choose
      display_moves
      update_history
      find_winner
      display_winner
      update_scores
      display_scores
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play