class Player 
    attr_accessor :inputs
    def initialize
        @inputs = []
    end

    def make_guess
        guess = nil
        until guess
            print "\nYour Guess: "
            input = gets.chomp.strip.downcase
            if ("a".."z").to_a.include?(input) || input == "save"
                guess = input
                self.inputs.push(guess)
            end 
        end
    return guess
    end
end