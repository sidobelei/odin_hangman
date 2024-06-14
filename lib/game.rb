require_relative "./player.rb"
require_relative "./game_view.rb" 

class Game
    attr_accessor :word_array, :mistakes, :game_over, :game_status

    def initialize(dictionary_file)
        #@save_file = get_save
        @player = Player.new
        @mistakes = 0
        @word_length = (5..12).to_a
        @word_array = {}
        @word = get_word(dictionary_file)
        @board = GameView.new(@word)
        @game_over = false
        @game_status = "lose"
    end

    def get_word(file)
        dictionary = File.read(file).split("\n")
        word = nil
        until word
            entry = dictionary[rand(dictionary.length - 1)]
            if @word_length.include?(entry.length)
                word = entry
            end
        end
        make_word_array(word)
        return word
    end

    def make_word_array(word)
        split_word = word.split("")
        split_word.each_with_index do |letter, index|
            unless word_array.has_key?(letter.to_sym)
                self.word_array[letter.to_sym] = [index]
            else
                self.word_array[letter.to_sym].push(index)
            end
        end
    end

    def check_guess(guess)
        if word_array.has_key?(guess.to_sym)
            correct_guess = [guess]
            word_array[guess.to_sym].each do |position|
                correct_guess.push(position)
            end
            return correct_guess
        else
            self.mistakes += 1
            return nil
        end
    end

    def play
        until game_over
            @board.display
            puts "   Previous Guesses: #{@player.inputs}" 
            guess = @player.make_guess
            checked_guess = check_guess(guess)
            @board.update_display(checked_guess, @mistakes)
            if mistakes == 6
                self.game_over = true
            elsif @board.word_display == @word.split("")
                 self.game_over = true
                 self.game_status = "win"
            end
        end
        @board.display
        puts "\n\nYou #{@game_status}! The word was #{@word.upcase}."
    end
end