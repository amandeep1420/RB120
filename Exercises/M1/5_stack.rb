class InvalidMinilangProgramError < NoMethodError; end
  
class Minilang
  attr_accessor :register, :stack, :inputs
  VALID_INPUTS = %w(PUSH ADD SUB MULT DIV MOD POP PRINT)
  
  def initialize(inputs)
    @register = 0
    @stack = []
    @inputs = inputs.split(' ')
  end
  
  def eval
      @inputs.each do |input|
        if input == input.to_i.to_s
          @register = input.to_i
        else
          raise InvalidMinilangProgramError if !VALID_INPUTS.include?(input)
          self.send(input.downcase)
        end
      end
  end
  
  def push
    @stack << @register
  end
  
  def add
    @register += @stack.pop
  end
  
  def sub
    @register -= @stack.pop
  end
  
  def mult
    @register *= @stack.pop
  end
  
  def div
    @register /= @stack.pop
  end
  
  def mod
    @register %= @stack.pop
  end
  
  def pop
    @register = @stack.pop
  end
  
  def print
    puts @register
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5
Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!
Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB