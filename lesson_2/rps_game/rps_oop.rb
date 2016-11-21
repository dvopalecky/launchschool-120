# Rock Paper Scissors Lizard Spock Game in OOP

module Helpers
  def prompt(message)
    message.split("\n").each do |line|
      puts "=> #{line}"
    end
  end
end

class RPSGame
  include Helpers

  attr_accessor :human, :computer
  def initialize
    display_welcome_msg
    @human = Human.new
    @computer = Computer.new
  end

  def play
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  def play_again?
    prompt "Do you want to play again? (Y)es or (N)o?"
    loop do
      answer = gets.chomp.downcase
      return true if answer == 'y'
      return false if answer == 'n'
      prompt "Please enter Y or N"
    end
  end

  def display_welcome_msg
    prompt "Welcome to RPS Game"
  end

  def display_goodbye_message
    prompt "Thanks for playing. Goodbye."
  end

  def display_moves
    prompt "#{human.name} chose: #{human.move}"
    prompt "#{computer.name} chose: #{computer.move}"
  end

  def display_winner
    if human.move > computer.move
      prompt "#{human.name} won."
    elsif computer.move > human.move
      prompt "#{computer.name} won."
    else
      prompt "It's a tie."
    end
  end
end

class Move
  VALID_CHOICES = %w(r p s).freeze
  FULLNAME_CHOICES = %w((R)ock (P)aper (S)cissors).freeze
  DUEL_MATRIX = [[0, -1, 1],
                 [1, 0, -1],
                 [-1, 1, 0]].freeze
  # DUEL_MATRIX = [[0, -1, 1, 1, -1],
  #               [1, 0, -1, -1, 1],
  #               [-1, 1, 0, 1, -1],
  #               [-1, 1, -1, 0, 1],
  #               [1, -1, 1, -1, 0]]

  attr_accessor :choice

  def initialize(choice)
    @choice = VALID_CHOICES.index(choice)
  end

  def >(other_move)
    return true if DUEL_MATRIX[@choice][other_move.choice] == 1
    false
  end

  def <(other_move)
    return true if DUEL_MATRIX[@choice][other_move.choice] == -1
    false
  end

  def to_s
    FULLNAME_CHOICES[@choice]
  end
end

class Player
  include Helpers

  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def choose
    loop do
      prompt "Choose one: #{Move::FULLNAME_CHOICES.join(', ')}"
      answer = gets.chomp.downcase
      if Move::VALID_CHOICES.include?(answer)
        self.move = Move.new(answer)
        break
      else
        prompt "Not a valid choice."
      end
    end
  end

  def set_name
    n = ""
    loop do
      prompt "What's your name?"
      n = gets.chomp
      break unless n.empty?
      "Sorry. Please enter a value."
    end
    self.name = n
  end
end

class Computer < Player
  def choose
    self.move = Move.new(Move::VALID_CHOICES.sample)
  end

  def set_name
    self.name = %w(R2D2 ET Hal Chappie Sonny).sample
  end
end

RPSGame.new.play
