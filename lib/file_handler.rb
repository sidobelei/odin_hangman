require "json"
module FileHandler
    def load_save
    end
    def create_save(game)
        unless Dir.exist?("../Saves")
            Dir.mkdir "../Saves"
        end
        File.open("../Saves/test.json", "w") do |file|
            file.write(game.to_json)
        end
    end
end