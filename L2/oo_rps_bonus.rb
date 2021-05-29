class Move
  VALUES = %w(rock paper scissors)

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

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
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
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid input."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(R2D2 C-3PO Big-O Ultimate-Mechamaru).sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer, :round_winner, :grand_winner
  
  MAX_SCORE = 3

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

  def reset_game_state
    self.round_winner = nil
    players = [human, computer]
    if players.any? { |player| player.score == MAX_SCORE }
      players.each { |player| player.score = 0 }
    end
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      find_winner
      update_scores
      display_winner
      display_scores
      break unless play_again?
      reset_game_state
    end
    display_goodbye_message
  end
end

RPSGame.new.play