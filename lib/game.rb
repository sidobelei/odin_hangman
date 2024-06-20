require_relative "player"
require_relative "game_view"
require_relative "file_handler"

class Game
    DICTIONARY_FILE = "./data/google-10000-english-no-swears.txt" 
    
    include FileHandler

    attr_accessor :word_array, :mistakes, :game_over, :game_status

    def initialize
        @word_length = (5..12).to_a
        print "Do you want to load a save file? "
        answer = gets.chomp.strip.downcase
        if answer == "yes" || answer == "y"
            file_found = false
            file = nil
            until file_found  
                print "Please enter a file name: "
                input = SAVE_DIRECTORY + gets.chomp
                if File.exist?(input)
                    file = input
                    file_found = true
                else
                    puts "\nFile does not exist, try again."
                end
            end
            get_save(file)
        else
            @player = Player.new
            @mistakes = 0
            @word_array = {}
            @word = get_word(DICTIONARY_FILE)
            @board = GameView.new(@word)
            @game_over = false
            @game_status = "lose"
        end
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
        p word_array
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
            if guess == "save"
                create_save(self)
                return puts "\nSaved Sucessfully"
            end
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

    def get_save(file_name)
        game_states = load_save(file_name)
        game_states.each do |key, value|
            if key == "player"
                new_player = Player.new
                value = new_player.from_json(value)
            elsif key == "board"
                new_board = GameView.new
                value = new_board.from_json(value)
            end
            self.instance_variable_set("@#{key}", value)
        end
        self.word_array = word_array.transform_keys(&:to_sym) 
    end

    def to_json(*args)
        {
            'player' => @player,
            'mistakes' => @mistakes,
            'word_array' => @word_array,
            'word' => @word,
            'board' => @board,
            'game_over' => @game_over,
            'game_status' => @game_status
        }.to_json
    end
end