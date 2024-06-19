class GameView
    attr_accessor :word_display, :hangman_array
    def initialize(word = nil)
        @hangman_array = [
            ["    _____"],
            ["   |     |"],
            ["   |     ", ""],
            ["   |    ", " ", "", ""],
            ["   |    ", "", " ", ""],
            ["   |"],
            [" -----"]
        ]
        @word_display = Array.new(word.length, "_") unless word.nil?
        @hangman_parts = {
            :"head" => ["o", 2, 1],
            :"torso" => ["|", 3, 2],
            :"left_arm" => ["/", 3, 1],
            :"right_arm" => ["\\", 3, 3],
            :"left_leg" => ["/", 4, 1],
            :"right_leg" => ["\\", 4, 3]
        }
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
    end

    def update_display(guess, mistakes)
        update_word_display(guess)
        update_hangman(mistakes)
    end

    def update_word_display(guess)
        letter = nil
        if guess
            guess.each_with_index do |value, index|
                if index == 0
                    letter = value
                else
                    self.word_display[value] = letter  
                end
            end
        end 
    end

    def update_hangman(mistakes)
        body_parts = [:head, :torso, :left_arm, :right_arm, :left_leg, :right_leg]
        if mistakes != 0
            until mistakes == 0
                mistakes = mistakes - 1
                limb = body_parts[mistakes]
                body_part = @hangman_parts[limb][0]
                row = @hangman_parts[limb][1]
                column = @hangman_parts[limb][2]
                self.hangman_array[row][column] = body_part 
            end
        end
    end

    def to_json(*args)
        {
            'hangman_array' => @hangman_array,
            'word_display' => @word_display
        }.to_json
    end

    def from_json(args)
        args.each do |key, value|
            self.instance_variable_set("@#{key}", value)
        end
        return self
    end

end