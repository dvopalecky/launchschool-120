# Twenty One in OOP

class Participant
  attr_accessor :name, :hand, :has_stayed, :score

  def initialize
    @score = 0
  end

  def reset(deck)
    @hand = Hand.new
    2.times { @hand.draw_card(deck) }
    @has_stayed = false
  end

  def stayed?
    @has_stayed
  end

  def busted?
    @hand.busted?
  end

  def <(other)
    hand.value < other.hand.value
  end

  def >(other)
    hand.value > other.hand.value
  end
end

class Player < Participant
  def initialize
    @name = "Player"
    super
  end

  def move(deck)
    if hit?
      @hand.draw_card(deck)
    else
      @has_stayed = true
    end
  end

  def hit?
    puts "Do you want to (H)it or (S)tay?"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if %w(h s).include?(answer)

      puts "Invalid input. Please enter H or S."
    end

    answer == 'h'
  end
end

class Dealer < Participant
  THRESHOLD = 17

  def initialize
    @name = "Dealer"
    super
  end

  def reset(deck)
    super
    @hand.cards[0].is_visible = false
  end

  def move(deck)
    if @hand < THRESHOLD
      @hand.draw_card(deck)
    else
      @has_stayed = true
    end
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::CARD_NAMES.each_index do |name_index|
      Card::CARD_SUITS.each_index do |suit_index|
        @cards << Card.new(name_index, suit_index)
      end
    end

    @cards.shuffle!
  end
end

class Card
  CARD_NAMES = %w(2 3 4 5 6 7 8 9 10 J Q K A).freeze
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, :ace].freeze
  CARD_SUITS = [:hearts, :diamonds, :clubs, :spades].freeze

  attr_accessor :value, :name, :suit, :is_visible

  def initialize(name_index, suit_index)
    @name = CARD_NAMES[name_index]
    @value = CARD_VALUES[name_index]
    @suit = CARD_SUITS[suit_index]
    @is_visible = true
  end

  def to_s
    if visible?
      "#{@name} of #{@suit.capitalize}"
    else
      "Invisible card"
    end
  end

  def visible?
    @is_visible
  end
end

class Hand
  BUSTED_THRESHOLD = 21

  attr_accessor :cards

  def initialize
    @cards = []
  end

  def value
    sum = 0
    sum_aces = 0
    @cards.each do |card|
      if card.value == :ace
        sum_aces += 1
        sum += 11
      else
        sum += card.value
      end
    end

    sum_aces.times do
      break if sum <= BUSTED_THRESHOLD
      sum -= 10
    end

    sum
  end

  def busted?
    value > BUSTED_THRESHOLD
  end

  def draw_card(deck)
    @cards << deck.cards.pop
  end

  def to_s
    total = @cards.all?(&:visible?) ? value : "Unknown"
    busted = busted? ? " BUSTED" : ""
    "#{@cards.each(&:to_s).join(', ')} (Total: #{total}#{busted})"
  end

  def <(num)
    value < num
  end

  def >(num)
    value > num
  end

  def make_visible
    @cards.each { |card| card.is_visible = true }
  end
end

class TwentyOneGame
  POINTS_TO_WIN = 3

  def initialize
    @player = Player.new
    @dealer = Dealer.new
  end

  def play
    display_welcome_message
    loop do
      loop do
        play_round
        break if game_over?

        press_enter
      end

      display_game_over
      break unless play_again?
    end

    display_goodbye_message
  end

  private

  def reset
    @deck = Deck.new
    @player.reset(@deck)
    @dealer.reset(@deck)
  end

  def play_round
    reset
    player_turn
    dealer_turn
    detect_result
    update_score
    display_table
    display_result
  end

  def game_over?
    @player.score >= POINTS_TO_WIN || @dealer.score >= POINTS_TO_WIN
  end

  def play_again?
    puts "Do you want to play again? (Y)es or (N)o"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)

      puts "Invalid input. Please enter Y or N"
    end

    answer == 'y'
  end

  def display_goodbye_message
    puts "Thanks for playing"
  end

  def display_welcome_message
    puts "Welcome to Twenty One Game."
    puts "Let's play to #{POINTS_TO_WIN} winning points."
    puts "Press enter to start."
    gets
  end

  def display_game_over
    game_result = @player.score > @dealer.score ? "You won :)" : "You lost :("
    puts "Game over. #{game_result}"
  end

  def press_enter
    puts "Press enter to continue"
    gets
  end

  def player_turn
    loop do
      display_table
      @player.move(@deck)
      break if @player.busted? || @player.stayed?
    end
  end

  def dealer_turn
    unless @player.busted?
      loop do
        @dealer.move(@deck)
        break if @dealer.busted? || @dealer.stayed?
      end
    end

    @dealer.hand.make_visible
  end

  def detect_result
    @result = if @player.busted?
                :player_busted
              elsif @dealer.busted?
                :dealer_busted
              elsif @player > @dealer
                :player
              elsif @player < @dealer
                :dealer
              else
                :tie
              end
  end

  def update_score
    case @result
    when :dealer_busted, :player then @player.score += 1
    when :player_busted, :dealer then @dealer.score += 1
    end
  end

  def display_result
    msg = case @result
          when :player_busted then "You busted. You LOOSE."
          when :dealer_busted then "You WIN. Dealer busted."
          when :player then "You WIN. Your total is higher."
          when :dealer then "You LOOSE. Dealer's total is higher."
          when :tie then "It's a TIE."
          end
    puts "Round Results: #{msg}"
    puts
  end

  def display_table
    clear_screen
    puts "Total score: #{@player.score} : #{@dealer.score}"\
      " (#{@player.name} : #{@dealer.name})"
    puts
    puts "#{@player.name}'s cards:"
    puts @player.hand
    puts
    puts "#{@dealer.name}'s cards:"
    puts @dealer.hand
    puts
  end

  def clear_screen
    system('clear') || system('cls')
  end
end

game = TwentyOneGame.new
game.play
