require "json"

module FileHandler
    SAVE_DIRECTORY = "../Saves/"

    def load_save(game_file)
        string = File.read(game_file)
        loaded_save = JSON.load(string)
        return loaded_save
    end

    def create_save(game)
        unless Dir.exist?(SAVE_DIRECTORY)
            Dir.mkdir SAVE_DIRECTORY
        end
        File.open(SAVE_DIRECTORY + "test.json", "w") do |file|
            file.write(game.to_json)
        end
    end
end