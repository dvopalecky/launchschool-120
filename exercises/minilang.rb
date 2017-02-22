class MinilangProcessor
  def initialize
    @stack = []
    @register = 0
  end

  def minilang(string)
    commands = to_commands(string)
    commands.each { |command| process(command) }
    nil
  end

  private

  def to_commands(string)
    string.split(' ')
  end

  def process(command)
    case command
    when "ADD" then add
    when "SUB" then subtract
    when "MULT" then multiply
    when "DIV" then divide
    when "MOD" then modulo
    when "POP" then pop
    when "PUSH" then push
    when "PRINT" then print_register
    else put_into_register(command.to_i)
    end
  end

  def put_into_register(number)
    @register = number
  end

  def push
    @stack.push(@register)
  end

  def pop
    @register = @stack.pop
  end

  def add
    @register += @stack.pop
  end

  def multiply
    @register *= @stack.pop
  end

  def subtract
    @register -= @stack.pop
  end

  def divide
    @register /= @stack.pop
  end

  def modulo
    @register = @register % @stack.pop
  end

  def print_register
    puts @register
  end
end

def minilang(string)
  MinilangProcessor.new.minilang(string)
end

minilang('PRINT')
# 0

minilang('5 PUSH 3 MULT PRINT')
# 15

minilang('5 PRINT PUSH 3 PRINT ADD PRINT')
# 5
# 3
# 8

minilang('5 PUSH POP PRINT')
# 5

minilang('3 PUSH 4 PUSH 5 PUSH PRINT ADD PRINT POP PRINT ADD PRINT')
# 5
# 10
# 4
# 7

minilang('3 PUSH PUSH 7 DIV MULT PRINT ')
# 6

minilang('4 PUSH PUSH 7 MOD MULT PRINT ')
# 12

minilang('-3 PUSH 5 SUB PRINT')
# 8

minilang('6 PUSH')

minilang("3 PUSH 5 MOD PUSH 7 PUSH 5 PUSH 4 MULT PUSH 3 ADD SUB DIV PRINT")
