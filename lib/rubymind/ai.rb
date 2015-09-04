class AI
  def initialize
    @solutions = create_solution_set
    @board = Board.new
    @board.respond("1122")
    begin
      a = guess(@board)
    end until @board.respond(a)
  end


  def create_solution_set
    set = Array.new
    for i in 0..5
      for j in 0..5
        for k in 0..5
          for l in 0..5
            set.push("#{i}#{j}#{k}#{l}")
          end
        end
      end
    end
    set.delete_if do |sol|
      sol.length != sol.chars.uniq.join.length
    end
    puts set
    puts set.count
    return set
  end

# Strategy: First, guess 1122 and get response pegs.
# Then, weed out all the the solutions that would not have gotten the same
# pegs. Then guess next
  def guess(playboard)
    guess_made = playboard.board[ (playboard.guesses_made - 1) ][:guess]
    answer_hash = playboard.board[ (playboard.guesses_made - 1) ]
    answer_hash.delete(:guess)
    @solutions.delete_if do |possible_solution|
      possible_solution unless test_result(guess_made, possible_solution) == answer_hash
    end
    puts "here are the solutions"
    puts @solutions
    return @solutions.sample
  end

  def test_result(guess, code)
    checked_chars = String.new
    exact = 0
    right_color = 0
    guess.chars.each_with_index do |char,index|
      if code[index] == char
        exact += 1
        checked_chars += char
      end
    end
    guess.chars.each do |char|
      if code.include?(char)
        right_color += 1 unless checked_chars.include?(char)
        checked_chars += char
      end
    end
    return { exact: exact, right_color: right_color }
  end

end
