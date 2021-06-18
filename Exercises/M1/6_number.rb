class GuessingGame
  MAX_NUM       = 100
  MAX_GUESSES = 7
  
  def initialize
    @winning_number = rand(MAX_NUM)
    @guesses        = MAX_GUESSES
    @won            = false
  end
  
  def play
    loop do
      guess
      break if out_of_guesses || won?
    end
    won_check
  end
  
  private
  
  def guess
    number = input_validation_loop
    
    guess_comparison(number)
  end
  
  def input_validation_loop
    puts "You have #{@guesses} guesses remaining."
    print "Enter a number between 1 and #{MAX_NUM}: "
    input = nil
    loop do
      input = gets.chomp.delete(' ')
      break if valid_num?(input)
      print "Invalid guess. Enter a number betweeen 1 and #{MAX_NUM}: "
    end
    input.to_i
  end
  
  def valid_num?(num)
    num.to_i.to_s == num && (1..MAX_NUM).cover?(num.to_i)
  end
  
  def guess_comparison(number)
    case
    when number == @winning_number
      puts "That's the number!"
      @won = true
      space
    when number > @winning_number 
      puts "Your guess is too high."
      @guesses -= 1
      space
    when number < @winning_number
      puts "Your guess is too low."
      @guesses -=1
      space
    end
  end
  
  def space
    puts ""
  end
  
  def won_check
    @won ? (puts "You won!") : (puts "You have no more guesses. You lost!")
  end
  
  def won?
    @won
  end
  
  def out_of_guesses
    @guesses == 0
  end
end

GuessingGame.new.play