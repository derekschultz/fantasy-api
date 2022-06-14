require 'rake'

desc 'import players from CBS'
task :initial_import => :environment do
  baseball_players = HTTParty.get("https://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=baseball&response_format=JSON")["body"]["players"]
  basketball_players = HTTParty.get("https://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=basketball&response_format=JSON")["body"]["players"]
  football_players = HTTParty.get("https://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=football&response_format=JSON")["body"]["players"]

  baseball_players.each do |player|
    player["sport"] = "baseball"
  end

  basketball_players.each do |player|
    player["sport"] = "basketball"
  end

  football_players.each do |player|
    player["sport"] = "football"
  end

  # remove ineligible data such as team stats and positionless players
  all_players = (baseball_players + basketball_players + football_players)
                .reject { |player| ["PS", "INF", "DST", "TQB", "ST", "D","null", ""].include? player["position"] }
  all_positions = all_players.map { |player| player["position"] }.uniq

  # each_with_object creates a hash so we can map each position to an average age
  average_age_by_position = all_positions.each_with_object({}) do |position, hash|
    average_position_age = position_average_age(all_players, position)
    hash[position] = average_position_age
  end

  # iterate through all_players array and save our relevant data to the DB
  all_players.each do |player|
    name_brief = brief_name(player["firstname"], player["lastname"], player["sport"])

    player_record = Player.new({
                    name_brief: name_brief,
                    full_name: player["fullname"],
                    first_name: player["firstname"],
                    last_name: player["lastname"],
                    position: player["position"],
                    age: player["age"],
                    average_position_age_diff: player["age"] ? (player["age"] - average_age_by_position[player["position"]]).abs : nil,
                    sport: player["sport"]
                  })
    player_record.save
  end
end

def brief_name(first, last, sport)
  case sport
  when "baseball" # print first and last initials
      "#{first[0]}. #{last[0]}."
  when "basketball" # print first name and last initial
      "#{first} #{last[0]}."
  when "football" # print first initial and last name
      "#{first[0]}. #{last}"
  end
end

def position_average_age(players, position)
  # select all players with an age that have a position
  players_in_position = players.select { |player| player["age"] != nil && player["position"] == position }

  # sum the age of players_in_position array
  total_age_in_position = players_in_position.map { |player| player["age"] }.sum

  (total_age_in_position / players_in_position.length).round
end