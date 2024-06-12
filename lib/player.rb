class Player 
    def initialize
        @inputs = []
        #@guesses = 8
    end

    def make_guess
        guess = nil
        until guess
            print "Your Guess: "
            input = gets.chomp.downcase
            if ("a".."z").to_a.include?(input) || input == "save"
                guess = input
            end 
        end
    return guess
    end
end