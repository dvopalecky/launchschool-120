# Tic Tac Toe in OOP

class Helpers
  def self.clear_screen
    system('clear') || system('cls')
  end
end

class TTTGame
  attr_accessor :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
  end

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

class Player
  attr_reader :name, :marker
  attr_accessor :score

  def initialize
    @score = 0
  end
end

class Human < Player
  MARKER = 'X'

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
    board[square] = self.marker
  end
end

class Computer < Player
  MARKER = 'O'

  def initialize
    @name = "Computer"
    @marker = MARKER
  end

  def mark_square(board)
    square = board.unmarked_keys.sample
    board[square] = self.marker
  end

end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    (1..9).each do |key|
      @squares[key] = Square.new
    end
  end

  def reset
    @squares.each do |_, square|
      square.reset
    end
  end

  def []= (square, marker)
    @squares[square].marker = marker
  end

  def unmarked_keys
    @squares.select { |_, square| square.unmarked? }.keys
  end

  def game_over?
    #full? || winner?(Human::MARKER) || winner?(Computer::MARKER)
    full? || winning_marker
  end

  def full?
    unmarked_keys.empty?
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def display
    arr_keys = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    display_dashes
    arr_keys.each do |value|
      display_row(value)
      display_dashes
    end
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end

  def display_dashes
    puts "-------------"
  end

  def display_row(row)
    message = "|"
    row.each do |key|
      message += " #{@squares[key].to_s.red} |"
    end
    puts message
  end
end

class Square
  DEFAULT_MARKER = ' '
  attr_accessor :marker

  def initialize
    reset
  end

  def reset
    @marker = DEFAULT_MARKER
  end

  def marked?
    @marker != DEFAULT_MARKER
  end

  def unmarked?
    @marker == DEFAULT_MARKER
  end

  def to_s
    @marker
  end
end

game = TTTGame.new
game.play
