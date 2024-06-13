class GameView
    def initialize(word)
        @hangman_array = [
            ["    _____"],
            ["   |     |"],
            ["   |     ", "o"],
            ["   |    ", "/", "|", "\\"],
            ["   |    ", "/", " ", "\\"],
            ["   |"],
            [" -----"]
        ]
        @word_display = Array.new(word.length, "_")
    end

    def display
        @hangman_array.each do |line|
            line.each do |element|
                print element
            end
            puts "\n"
        end
        puts "\n"
        @word_display.each do |letter|
            print " " + letter 
        end
        puts "\n" 
    end
end