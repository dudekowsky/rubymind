class Game
  def Game.start
    @board = Board.new
    puts "Welcome to Rubymind! Your board has been created. Enter 'help' for rules!"
    begin
      puts "Enter your guess!"
      guess = gets.chomp
      if guess.downcase == "help"
        puts "Rules: You have to solve a code. It has 4 Numbers, 0-5, no duplicates. \n" +
        "Each round you will receive the number of exact hits and the number of" +
        " correct numbers at the wrong position. You have 12 tries. Get going!"
        redo
      end
    end until @board.respond(guess)
  end
end
