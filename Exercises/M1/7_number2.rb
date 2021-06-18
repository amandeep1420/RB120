class GuessingGame
  def initialize(low_value, high_value)
    @low_value      = low_value
    @high_value     = high_value
    @range          = (high_value - low_value) + 1
    @winning_number = generate_secret_number
    @guesses        = generate_guess_count
    @won            = false
  end

  def play
    loop do
      clear
      guess
      break if out_of_guesses || won?
    end
    won_check
    continue
    reset_guess_count
    reset_winning_number
  end

  private

  attr_reader :high_value, :low_value, :range
  attr_accessor :guesses, :winning_number, :won

  def generate_secret_number
    (low_value..high_value).to_a.sample
  end

  def generate_guess_count
    Math.log2(range).to_i + 1
  end

  def clear
    system('clear')
  end

  def guess
    number = input_validation_loop

    guess_comparison(number)

    space
  end

  def input_validation_loop
    puts "You have #{guesses} guesses remaining."
    print "Enter a number between #{low_value} and #{high_value}: "
    input = nil
    loop do
      input = gets.chomp.delete(' ')
      break if valid_num?(input)
      print "Invalid guess. "
      print "Enter a number betweeen #{low_value} and #{high_value}: "
    end
    input.to_i
  end

  def valid_num?(num)
    num.to_i.to_s == num && (low_value..high_value).cover?(num.to_i)
  end

  def guess_comparison(number)
    if number == winning_number
      puts "That's the number!"
      self.won = true
    elsif number > @winning_number
      puts "Your guess is too high."
      self.guesses -= 1
    elsif number < @winning_number
      puts "Your guess is too low."
      self.guesses -= 1
    end
  end

  def space
    puts ""
  end

  def out_of_guesses
    guesses == 0
  end

  def won?
    @won
  end

  def won_check
    won ? (puts "You won!") : (puts "You have no more guesses. You lost!")
  end

  def continue
    puts "Press ENTER to close game. Thanks for playing!"
    STDIN.gets
  end

  def reset_game
    reset_guess_count
    reset_winning_number
  end

  def reset_guess_count
    self.guesses = generate_guess_count
  end

  def reset_winning_number
    self.winning_number = generate_secret_number
  end
end

game = GuessingGame.new(1, 10)

game.play

game.play # able to call method again on same object for fresh game
