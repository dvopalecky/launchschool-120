# Rock Paper Scissors Lizard Spock Game in OOP

module Helpers
  def prompt(message)
    message.split("\n").each do |line|
      puts "=> #{line}"
    end
  end

  def clear_screen
    system('clear') || system('cls')
  end
end

class RPSGame
  POINTS_TO_WIN = 4
  include Helpers

  attr_accessor :human, :computer, :history
  def initialize
    display_welcome_msg
    @human = Human.new
    @computer = [R2D2, ET, Sonny].sample.new
    @history = History.new
  end

  def play
    loop do
      display_scores
      loop do
        play_round
        break if game_over?
      end
      display_game_winner
      history.display(human.name, computer.name)
      break unless play_again?
      reset_scores_and_history
      @computer = [R2D2, ET, Sonny].sample.new
    end
    display_goodbye_message
  end

  def play_round
    human.choose
    computer.choose(history)
    history.update(human.move, computer.move)
    display_moves
    display_winner
    update_scores
    display_scores
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

  def game_over?
    human.score >= POINTS_TO_WIN || computer.score >= POINTS_TO_WIN
  end

  def display_welcome_msg
    clear_screen
    prompt "Welcome to RPS Extended Game"
  end

  def display_goodbye_message
    prompt "Thanks for playing. Goodbye."
  end

  def display_moves
    clear_screen
    prompt "#{human.name} chose: #{human.move}"
    prompt "#{computer.name} chose: #{computer.move}"
  end

  def display_scores
    msg = "Score: #{human.score} : #{computer.score}" \
          " (#{human.name} : #{computer.name})"
    prompt msg
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

  def display_game_winner
    winner = human.score > computer.score ? human.name : computer.name
    prompt "Game over. #{winner} won."
  end

  def update_scores
    case Move.duel(human.move, computer.move)
    when 1 then human.score += 1
    when -1 then computer.score += 1
    end
  end

  def reset_scores_and_history
    human.score = 0
    computer.score = 0
    history.reset
  end
end

class Move
  VALID_CHOICES = %w(r p s l k).freeze
  FULLNAME_CHOICES = %w((R)ock (P)aper (S)cissors (L)izard Spoc(K)).freeze
  DUEL_MATRIX = [[0, -1, 1, 1, -1],
                 [1, 0, -1, -1, 1],
                 [-1, 1, 0, 1, -1],
                 [-1, 1, -1, 0, 1],
                 [1, -1, 1, -1, 0]].freeze

  attr_accessor :choice

  def self.duel(move1, move2)
    DUEL_MATRIX[move1.choice][move2.choice]
  end

  def initialize(choice)
    @choice = VALID_CHOICES.index(choice)
  end

  def >(other_move)
    DUEL_MATRIX[@choice][other_move.choice] == 1
  end

  def <(other_move)
    DUEL_MATRIX[@choice][other_move.choice] == -1
  end

  def to_s
    FULLNAME_CHOICES[@choice]
  end
end

class History
  include Helpers

  attr_reader :history

  def initialize
    @history = []
  end

  def reset
    initialize
  end

  def update(human_move, computer_move)
    history << { human_move: human_move, computer_move: computer_move }
  end

  def display(human_name, computer_name)
    prompt "- - - - - - - - - - -"
    prompt "Game History Overview"
    prompt "Move # : #{human_name} : #{computer_name}"
    history.each_with_index do |value, i|
      prompt "#{i + 1} : #{value[:human_move]} : #{value[:computer_move]}"
    end
    prompt "- - - - - - - - - - -"
  end
end

class Player
  include Helpers

  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
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
  def choose(_history)
    self.move = Move.new(Move::VALID_CHOICES.sample)
  end

  def set_name
    self.name = %w(R2D2 ET Hal Chappie Sonny).sample
  end
end

class R2D2 < Computer
  def choose(_history)
    # always chooses rock
    self.move = Move.new(Move::VALID_CHOICES[0])
  end

  def set_name
    self.name = "R2D2"
  end
end

class ET < Computer
  def choose(history)
    # chooses last move of human player
    self.move = if history.history.empty?
                  Move.new(Move::VALID_CHOICES.sample)
                else
                  history.history[-1][:human_move]
                end
  end

  def set_name
    self.name = "ET"
  end
end

class Sonny < Computer
  def choose(_history)
    # Rock: 10%, Paper: 10%, Scissors: 60%, Lizard: 10%, Spock: 10%
    arr_choices = %w(r p s s s s s s l k)
    self.move = Move.new(arr_choices.sample)
  end

  def set_name
    self.name = "Sonny"
  end
end

RPSGame.new.play
