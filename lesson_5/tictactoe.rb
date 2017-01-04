# Tic Tac Toe in OOP

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

  def initialize
    @score = 0
  end
end

class Human < Player
  MARKER = Square.new("X", :red)

  def initialize
    @name = "Human"
    @marker = MARKER
  end

  def mark_square(board)
    square = nil
    loop do
      puts "Select square (#{board.unmarked_keys.join(', ')})"
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
    square = board.unmarked_keys.sample
    board[square] = marker
  end
end

class Board
  ARR_KEYS = [[1, 2, 3], [4, 5, 6], [7, 8, 9]].freeze
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

  def game_over?
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
    ARR_KEYS.each do |value|
      display_row(value)
      display_dashes
    end
  end

  private

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

class TTTGame
  attr_accessor :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
  end

  # rubocop:disable Metrics/MethodLength
  def play
    display_welcome_message
    loop do
      @player = @human # who starts
      display_board
      loop do
        @player.mark_square(@board)
        clear_screen_and_display_board
        switch_player
        break if @board.game_over?
      end
      display_result
      break unless play_again?
      @board.reset
      display_play_again_message
    end
    display_goodbye_message
  end
  # rubocop:enable Metrics/MethodLength

  private

  def switch_player
    @player = @player == @human ? @computer : @human
  end

  def clear_screen_and_display_board
    Helpers.clear_screen
    display_board
  end

  def display_board
    puts "You are #{Human::MARKER}, computer is #{Computer::MARKER}."
    @board.display
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe"
  end

  def display_goodbye_message
    puts "Thanks for playing"
  end

  def display_play_again_message
    Helpers.clear_screen
    puts "Let's play again|"
  end

  def display_result
    case @board.winning_marker
    when Human::MARKER
      puts "You won!"
    when Computer::MARKER
      puts "Computer won!"
    else
      puts "It's a tie."
    end
  end

  def play_again?
    puts "Do you want to play again? (Y)es or (N)o"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Please answer Y or N"
    end
    answer == 'y'
  end
end

game = TTTGame.new
game.play
