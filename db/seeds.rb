require 'faker'
require 'json'

puts "Cleaning db..."
User.destroy_all
Team.destroy_all
Spot.destroy_all

puts "Creating teams... "

team1 = Team.create!(name: Faker::Team.name)
team2 = Team.create!(name: Faker::Team.name)
team3 = Team.create!(name: Faker::Team.name)

teams = [team1, team2, team3]

puts "Creating users"

addresses = ["20 Rue des Capucins, 69001 Lyon", "85 Cours Albert Thomas, 69003, Lyon", "5 Place Saint-Jean, 69005, Lyon", "251 Rue Paul Bert, 69003, Lyon,", "3 Place Bertone, 69004, Lyon", "48 Rue Henon, 69004, Lyon", "11 Place du Marechal Lyautey, 69006, Lyon", "32 Rue de Marseille, 69007, Lyon", "19 Rue Royale, 69001, Lyon", "8 Rue de la Navigation, 69009, Lyon", "21 Quai Victor Augagneur, 69003, Lyon", "33 Avenue Jean Jaures, 69007, Lyon", "11 Boulevard Marius Vivier Merle, 69003, Lyon", "40 Rue de l'Abondance, 69003, Lyon", "16 Quai de Bondy, 69005, Lyon",]

addresses.each_with_index do |address, i|
  counter = i + 1
  u = User.create!(
    email: "test#{counter}@test.com",
    password: "123456",
    address: address,
    username: Faker::FunnyName.unique.name,
    team: teams[counter % teams.size]
  )
  puts u.email
end

puts "Users have been created!"

puts "Users have been assigned to teams!"

teams.each { |t| puts "#{t.name} has #{t.users.size}" }

filepath = "db/Cartographie_des_Jardins_de_rue_au_1er_janvier_2022.geojson"
document = File.read(filepath)
response = JSON.parse(document)
spots_data = response["features"]

spots_data.each do |spot_data|
  random_team = teams.sample.id
  p Spot.create!(
    name: spot_data["properties"]["Name"],
    latitude: spot_data["properties"]["Lat"],
    longitude: spot_data["properties"]["Lon"],
    spot_type: spot_data["properties"]["Type_de_V__g__talisation"],
    team_id: random_team,
    is_open: true
  )
end

puts "Finished!"
