class Mastermind
  COLORS = %w(r g b y)
  MAX_GUESSES = 12

  def initialize
    @secret_code = generate_secret_code
    @guesses = []
  end

  def play
    puts "Welcome to MASTERMIND\n\n"
    loop do
      print "Would you like to (p)lay, read the (i)nstructions, or (q)uit?\n> "
      input = gets.chomp.downcase
      case input
      when 'p', 'play'
        reset_game
        play_game
      when 'i', 'instructions'
        show_instructions
      when 'q', 'quit'
        exit_game
      else
        puts "Invalid input. Please enter 'p', 'i', or 'q'."
      end
    end
  end

  private

  def generate_secret_code
    COLORS.sample(4)
  end

  def reset_game
    @secret_code = generate_secret_code
    @guesses = []
  end

  def play_game
    puts "\nI have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game."
    start_time = Time.now
    (1..MAX_GUESSES).each do |guess_num|
      print "\nGuess ##{guess_num}: "
      guess = gets.chomp.downcase
      case guess
      when 'q', 'quit'
        exit_game
      when 'c', 'cheat'
        puts "Secret code: #{@secret_code}"
        redo
      when /\A[rgby]{4}\z/
        result = check_guess(guess.chars)
        puts "#{guess.upcase} has #{result[0]} of the correct elements with #{result[1]} in the correct positions\nYou've taken #{guess_num} guess#{guess_num == 1 ? '' : 'es'}"
        if guess.chars == @secret_code
          end_time = Time.now
          elapsed_time = end_time - start_time
          minutes = elapsed_time / 60
          seconds = elapsed_time % 60
          puts "\nCongratulations! You guessed the sequence '#{guess.upcase}' in #{guess_num} guess#{guess_num == 1 ? '' : 'es'} over #{minutes.floor} minute#{minutes.floor == 1 ? '' : 's'}, #{seconds.floor} second#{seconds.floor == 1 ? '' : 's'}."
          print "\nDo you want to (p)lay again or (q)uit?\n> "
          input = gets.chomp.downcase
          case input
          when 'p', 'play'
            reset_game
            play_game
          when 'q', 'quit'
            exit_game
          else
            puts "Invalid input. The game will quit."
            exit_game
          end
        end
      else
        puts "Invalid input. Guesses must be four characters long and can only contain the letters 'r', 'g', 'b', and 'y'."
      end
    end
    puts "\nYou have run out of guesses. The secret code was #{format_code(@secret_code)}."
    print "\nDo you want to (p)lay again or (q)uit?\n> "
    input = gets.chomp.downcase
    case input
    when 'p', 'play'
      reset_game
      play_game
    when 'q', 'quit'
    else
      puts "Invalid input. Please try again."
    end
  end
end
