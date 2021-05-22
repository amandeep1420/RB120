require 'pry'

class Banner
  
  def initialize(message, manual_set=false)
    @message = message
    @size = manual_set ? manual_set : message.size + 2
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+" + ('-' * @size) + '+'
  end

  def empty_line
    '|' + (' ' * @size) + '|'
  end
  
  def format_message
    sliced = nil
    letters = @message.chars
    loop do
      return @message if @message.size <= (@size - 2)
      sliced  = letters.each_slice(@size - 2).to_a
      break
    end
    @message = sliced
  end
      
  def message_line
    format_message
    binding.pry
    if @message.class == Array
      sliced   = @message.map do |arr| 
                  arr.unshift("| ")
                  @message.last == arr ? arr << " |" : arr << " |\n"
                 end
      @message = sliced.map(&:join).join
    else
      "|" + "#{@message.center(@size)}" + "|"
    end
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner = Banner.new('Hdsdsdsi', 3)
puts banner
