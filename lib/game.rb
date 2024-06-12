class Game
    attr_accessor :word_array, :guesses

    def initialize(dictionary_file)
        #@save_file = get_save
        #@player
        @word_length = (5..12).to_a
        @guesses = 8
        @word_array = {}
        @word = get_word(dictionary_file)
        @game_over = false
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
            return nil
        end
    end
end