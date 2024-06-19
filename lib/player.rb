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
                    if guess != "save"
                        self.inputs.push(guess)
                    end
            end 
        end
    return guess
    end

    def to_json(*args)
        {
            'inputs' => @inputs
        }.to_json
    end

    def from_json(states)
        states.each do |key, value|
            self.instance_variable_set("@#{key}", value)
        end
        return self
    end
end