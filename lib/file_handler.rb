require "json"

module FileHandler
    SAVE_DIRECTORY = "./data/saves/"

    def load_save(game_file)
        string = File.read(game_file)
        loaded_save = JSON.load(string)
        return loaded_save
    end

    def create_save(game)
        unless Dir.exist?(SAVE_DIRECTORY)
            Dir.mkdir SAVE_DIRECTORY
        end
        file_name = nil
        puts "\n"
        until file_name
            puts "Please type in your file name and include the \".json\" extension:"
            input = gets.chomp
            if input.include?(".json")
                file_name = input
            else
                puts "\nInvalid file name, try again."
            end
        end
        File.open(SAVE_DIRECTORY + file_name, "w") do |file|
            file.write(game.to_json)
        end
    end
end