class Player < ApplicationRecord
    def self.search(params)
        validates :first_name, :last_name, presence: true

        players = Player.all

        players = players.where("sport = ?", params["sport"]) if params["sport"]
        players = players.where("position = ?", params["position"]) if params["position"]
        players = players.where("age = ?", params["age"]) if params["age"]

        # select all players between min and max age range
        players = players.where("players.age >= ? AND players.age <= ?", params["min_age"], params["max_age"]) if params["min_age"] && params["max_age"]

        # fetch the first letter of the player's last name
        players = players.where("substr(players.last_name, 1, 1) = ?", params["first_letter_of_last_name"]) if params["first_letter_of_last_name"]

        players
    end
end
