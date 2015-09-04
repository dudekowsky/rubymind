class Board
  attr_reader :board, :guesses_made
  def initialize
    @code = create_code
    @board = []
    @guesses_made = 0
  end

  def create_code
    code = String.new
    for i in 1..4
      begin
      number = rand(6).to_s
      end while code.include?(number)
      code += number
    end
    return code
  end

  def respond(guess)
    checked_chars = String.new
    @guesses_made += 1
    exact = 0
    right_color = 0
    guess.chars.each_with_index do |char,index|
      if @code[index] == char
        exact += 1
        checked_chars += char
      end
    end
    guess.chars.each do |char|
      if @code.include?(char)
        right_color += 1 unless checked_chars.include?(char)
        checked_chars += char
      end
    end
    @board.push( { guess: guess, exact: exact, right_color: right_color } )
    @board.each_with_index do |entry, index|
      puts "Entry nr.#{index+1}: #{entry}"
    end
    if guess == @code
      puts "Congratulations! You won!"
      return true
    elsif @guesses_made == 12
      puts "You lost!"
      puts "The code was: #{@code}"
      return true
    else
      false
    end
  end

end
