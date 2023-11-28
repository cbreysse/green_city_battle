require 'faker'

puts "Cleaning db..."
User.destroy_all
Team.destroy_all

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

teams.each { |t| puts "#{t.name} has #{t.users.size}"}
puts "Users have been created!"

puts "Finished!"
