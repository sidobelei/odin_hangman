class Game
    def initialize(dictionary_file)
        #@save_file = get_save
        #@player
        @word_length = (5..12).to_a
        @guesses = 8
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
        return word
    end
end