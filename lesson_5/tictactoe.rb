# Tic Tac Toe in OOP
require 'pry'

class Array
  def joinor(delimiter = ', ', last_word = 'or')
    if size < 2
      join(delimiter)
    else
      self[0...-1].join(delimiter) + "#{delimiter}#{last_word} #{self[-1]}"
    end
  end
end

class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end

class Helpers
  def self.clear_screen
    system('clear') || system('cls')
  end

  def self.display_and_choose_menu(heading, integer_choices)
    clear_screen
    puts heading
    integer_choices.each do |key, choice|
      puts "(#{key}) #{choice}"
    end

    loop do
      answer = gets.chomp.to_i
      return answer if integer_choices.keys.include?(answer)
      puts "Invalid choice. Please choose #{integer_choices.keys.joinor}"
    end
  end
end

class Square
  DEFAULT_MARKER = ' '.freeze
  DEFAULT_COLOR = nil
  attr_accessor :marker

  def initialize(marker = DEFAULT_MARKER, color = nil)
    @marker = marker
    @color = color
  end

  def reset
    @marker = DEFAULT_MARKER
    @color = nil
  end

  def marked?
    @marker != DEFAULT_MARKER
  end

  def unmarked?
    @marker == DEFAULT_MARKER
  end

  def to_s
    if @color
      @marker.send(@color)
    else
      @marker
    end
  end
end

class Player
  attr_reader :name, :marker
  attr_accessor :score
end

class Human < Player
  attr_accessor :name
  MARKER = Square.new("X", :red)

  def initialize
    @name = "Player"
    @marker = MARKER
  end

  def mark_square(board)
    square = nil
    loop do
      puts "Select square (#{board.unmarked_keys.joinor(', ')})"
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)

      puts "Sorry, that's not a valid choice"
    end

    board[square] = marker
  end
end

class Computer < Player
  MARKER = Square.new("O", :green)

  def initialize
    @name = "Computer"
    @marker = MARKER
  end

  def mark_square(board)
    square = board.find_winning_square(Computer::MARKER) # offense
    square = board.find_winning_square(Human::MARKER) if !square # offense
    square = 5 if !square && board.unmarked_keys.include?(5)
    square = board.unmarked_keys.sample if !square

    board[square] = marker
  end
end

class Board
  KEYS = [[1, 2, 3], [4, 5, 6], [7, 8, 9]].freeze
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]].freeze

  def initialize
    @empty_square = Square.new
    @squares = {}
    (1..9).each do |key|
      @squares[key] = @empty_square
    end
  end

  def reset
    @squares.each do |key, _|
      @squares[key] = @empty_square
    end
  end

  def []=(square, marker)
    @squares[square] = marker
  end

  def unmarked_keys
    @squares.select { |_, square| square.unmarked? }.keys
  end

  def round_over?
    full? || winning_marker
  end

  def full?
    unmarked_keys.empty?
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first
      end
    end

    nil
  end

  def display
    display_dashes
    KEYS.each do |value|
      display_row(value)
      display_dashes
    end
  end

  def find_winning_square(offensive_marker)
    WINNING_LINES.each do |line| # try to win in 1 move
      next unless count_markers_on_line(line, offensive_marker) == 2
      selected = @squares.select do |k, v|
        line.include?(k) && v == @empty_square
      end

      square = selected.keys.first
      return square unless square.nil?
    end

    nil
  end

  private

  def count_markers_on_line(line, marker)
    @squares.values_at(*line).count(marker)
  end

  def display_dashes
    puts "-------------"
  end

  def display_row(row)
    message = "|"
    row.each do |key|
      message += " #{@squares[key]} |"
    end

    puts message
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end
end

class TTTGameSettings
  POINTS_TO_WIN = 2

  attr_accessor :points_to_win, :who_goes_first

  def initialize
    @points_to_win = POINTS_TO_WIN
    @who_goes_first = :player
  end

  def change(human)
    loop do
      heading = "Tic Tac Toe: Settings"
      menu = { 1 => "Points to win    | #{points_to_win}",
               2 => "Who goes first   | #{who_goes_first.capitalize}",
               3 => "Player name      | #{human.name}",
               4 => "Player symbol    | #{human.marker}",
               5 => "Exit to main menu" }
      case Helpers.display_and_choose_menu(heading, menu)
      when 1 then @points_to_win = change_points_to_win
      when 2 then @who_goes_first = change_who_goes_first
      when 3 then human.name = change_player_name
      when 4 then human.marker.marker = change_player_marker
      else break
      end
    end
  end

  private

  def change_points_to_win
    puts "How many points to win? (1 to 10)"
    loop do
      answer = gets.chomp.to_i
      return answer if (1..10).cover?(answer)
      puts "Invalid input. Enter 1 to 10."
    end
  end

  def change_who_goes_first
    heading = "Who goes first"
    menu = { 1 => "Player",
             2 => "Computer",
             3 => "Switch each round, first random" }
    case Helpers.display_and_choose_menu(heading, menu)
    when 1 then :player
    when 2 then :computer
    when 3 then :random
    end
  end

  def change_player_name
    puts "What is your name?"
    loop do
      answer = gets.chomp.strip
      return answer unless answer.empty?
      puts "Input can't be empty. Try again."
    end
  end

  def change_player_marker
    puts "What symbol do you want? (single character)"
    loop do
      answer = gets.chomp.strip
      return answer if answer.size == 1 && answer != Computer::MARKER.marker
      puts "Input must have 1 character and must not be "\
           "#{Computer::MARKER.marker}. Try again."
    end
  end
end

class TTTGame
  attr_accessor :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @settings = TTTGameSettings.new
    @player = nil
    @who_starts_round = nil
    @is_first_round = nil
  end

  def main
    heading = "Tic Tac Toe: Main Menu"
    menu = { 1 => "Play", 2 => "Settings", 3 => "Exit game" }
    loop do
      case Helpers.display_and_choose_menu(heading, menu)
      when 1 then play
      when 2 then @settings.change(@human)
      else break
      end
    end

    display_goodbye_message
  end

  private

  def play
    @is_first_round = true
    reset_score
    loop do
      play_round
      display_round_result
      break if game_over?

      press_any_key
    end

    display_game_result
    press_any_key
  end

  def press_any_key
    puts "Press enter to continue."
    gets
  end

  def play_round
    set_who_starts_round
    @player = @who_starts_round
    @board.reset
    loop do
      clear_screen_and_display_score_and_board
      @player.mark_square(@board)
      switch_player
      break if @board.round_over?
    end

    @is_first_round = false
    update_score
    clear_screen_and_display_score_and_board
  end

  def set_who_starts_round
    case @settings.who_goes_first
    when :player
      @who_starts_round = @human
    when :computer
      @who_starts_round = @computer
    when :random
      if @is_first_round
        @who_starts_round = [@human, @computer].sample
      else
        @who_starts_round = @who_starts_round == @human ? @computer : @human
      end
    end
  end

  def game_over?
    @human.score >= @settings.points_to_win ||
      @computer.score >= @settings.points_to_win
  end

  def switch_player
    @player = @player == @human ? @computer : @human
  end

  def clear_screen_and_display_score_and_board
    Helpers.clear_screen
    display_score_and_board
  end

  def display_score_and_board
    puts "You are #{Human::MARKER}, computer is #{Computer::MARKER}."
    puts "Score: #{@human.score} : #{@computer.score}"\
         " (#{human.name} : #{computer.name})"
    @board.display
  end

  def display_goodbye_message
    puts "Thanks for playing. Good bye"
  end

  def display_round_result
    msg = " Winner needs #{@settings.points_to_win} points."
    case @board.winning_marker
    when Human::MARKER
      puts "You won the round!#{msg}"
    when Computer::MARKER
      puts "Computer won the round!#{msg}"
    else
      puts "This round is a tie.#{msg}"
    end
  end

  def display_game_result
    if @human.score > @computer.score
      puts "You won the game!"
    else
      puts "Computer won the game!"
    end
  end

  def update_score
    case @board.winning_marker
    when Human::MARKER
      @human.score += 1
    when Computer::MARKER
      @computer.score += 1
    end
  end

  def reset_score
    @human.score = 0
    @computer.score = 0
  end
end

game = TTTGame.new
game.main
