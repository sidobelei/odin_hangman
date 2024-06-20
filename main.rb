require_relative "./lib/game.rb" 

puts "Welcome to Hangman!\n\n"
puts "How to play:" 
puts "- Guess the mystery word, one letter at time." 
puts "- If you want to save your current game just type in \"save\".\n\n"

game = Game.new
game.play