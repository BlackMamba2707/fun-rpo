class TicTacToe
  def initialize
    @board = Array.new(9, ' ')
    @current_player = 'X'
    @game_over = false
  end

  def play
    puts "\nWelcome to Tic Tac Toe!"
    puts "Players will take turns. X goes first."
    puts "Enter positions 1-9 as shown below:\n\n"
    show_position_guide
    
    until @game_over
      display_board
      make_move
      check_game_status
      switch_player unless @game_over
    end
  end

  private

  def show_position_guide
    puts " 1 | 2 | 3 "
    puts "-----------"
    puts " 4 | 5 | 6 "
    puts "-----------"
    puts " 7 | 8 | 9 "
    puts "\n"
  end

  def display_board
    puts "\nCurrent board:"
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    puts "\n"
  end

  def make_move
    position = nil
    
    loop do
      print "Player #{@current_player}, enter your move (1-9): "
      input = gets.chomp
      
      if input.match?(/^[1-9]$/)
        position = input.to_i - 1
        
        if @board[position] == ' '
          @board[position] = @current_player
          break
        else
          puts "That position is already taken! Try again."
        end
      else
        puts "Invalid input! Please enter a number between 1 and 9."
      end
    end
  end

  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end

  def check_game_status
    if winner?
      display_board
      puts "Player #{@current_player} wins! 🎉"
      @game_over = true
    elsif board_full?
      display_board
      puts "It's a tie! 🤝"
      @game_over = true
    end
  end

  def winner?
    winning_combinations = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],  # rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8],  # columns
      [0, 4, 8], [2, 4, 6]              # diagonals
    ]

    winning_combinations.any? do |combo|
      combo.all? { |pos| @board[pos] == @current_player }
    end
  end

  def board_full?
    !@board.include?(' ')
  end
end

# Start the game
if __FILE__ == $0
  loop do
    game = TicTacToe.new
    game.play
    
    print "\nWould you like to play again? (y/n): "
    answer = gets.chomp.downcase
    break unless answer == 'y'
    
    puts "\n" + "="*30 + "\n"
  end
  
  puts "\nThanks for playing! Goodbye! 👋"
end