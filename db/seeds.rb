puts "Cleaning db..."
Participation.destroy_all
ActionType.destroy_all
Event.destroy_all
EventType.destroy_all
User.destroy_all
Team.destroy_all
Spot.destroy_all

puts "Creating teams... "

team1 = Team.create!(name: "Team Lyon 1")
team2 = Team.create!(name: "Team Lyon 2")
team3 = Team.create!(name: "Team Lyon 3")
team4 = Team.create!(name: "Team Lyon 4")
team5 = Team.create!(name: "Team Lyon 5")
team6 = Team.create!(name: "Team Lyon 6")
team7 = Team.create!(name: "Team Lyon 7")
team8 = Team.create!(name: "Team Lyon 8")
team9 = Team.create!(name: "Team Lyon 9")

teams = [team1, team2, team3, team4, team5, team6, team7, team8, team9]

## demo user
puts "Creating main user..."

main_user = User.create!(
  email: "test@test.com",
  password: "123456",
  address: "20 Rue des Capucins, 69001 Lyon",
  username: "Jean Racine",
  team: team1
)
puts "Main user's email is #{main_user.email}"

puts "Creating users..."

addresses = ["85 Cours Albert Thomas, 69003, Lyon", "5 Place Saint-Jean, 69005, Lyon", "251 Rue Paul Bert, 69003, Lyon,", "3 Place Bertone, 69004, Lyon", "48 Rue Henon, 69004, Lyon", "11 Place du Marechal Lyautey, 69006, Lyon", "32 Rue de Marseille, 69007, Lyon", "19 Rue Royale, 69001, Lyon", "8 Rue de la Navigation, 69009, Lyon", "21 Quai Victor Augagneur, 69003, Lyon", "33 Avenue Jean Jaures, 69007, Lyon", "11 Boulevard Marius Vivier Merle, 69003, Lyon", "40 Rue de l'Abondance, 69003, Lyon", "16 Quai de Bondy, 69005, Lyon",]

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

puts "Creating actions..."

action1 = ActionType.create!(name: "water spot", points: 10)
action2 = ActionType.create!(name: "care", points: 10)
action3 = ActionType.create!(name: "plant", points: 20)
action4 = ActionType.create!(name: "denounce", points: -10)

p actions = [action1, action2, action3, action4]

puts "Actions created!"

puts "Creating spots..."

filepath = "db/Cartographie_des_Jardins_de_rue_au_1er_janvier_2022.geojson"
document = File.read(filepath)
response = JSON.parse(document)
spots_data = response["features"]

## demo spot
spot1 = Spot.create!(
  name: "Rue de l'Abbé Rozier",
  latitude: 45.7696049,
  longitude: 4.8339815,
  spot_type: "Végétalisation mixte",
  team_id: team1.id,
  is_open: true
)

photo1 = File.open(Rails.root.join('app/assets/images/planter.png'))
spot1.photo.attach(io: photo1, filename: "planter.jpg")

spot2 = Spot.create!(
  name: "Rue René Leynaud",
  latitude: 45.7698596,
  longitude: 4.8338336,
  spot_type: "Végétalisation mixte",
  team_id: team1.id,
  is_open: true
)

photo2 = File.open(Rails.root.join('app/assets/images/flower_bed.png'))
spot2.photo.attach(io: photo2, filename: "flower_bed.jpg")

## new spot in Lyon 1
new_spot1 = Spot.create!(
  name: "Place Chardonnet",
  latitude: 45.7708912,
  longitude: 4.834146,
  spot_type: "Végétalisation mixte",
  team_id: team1.id,
  is_open: false
)

new_spot2 = Spot.create!(
  name: "Quai Saint Vincent",
  latitude: 45.7684365,
  longitude: 4.8244804,
  spot_type: "Végétalisation mixte",
  team_id: team1.id,
  is_open: false
)

new_spot3 = Spot.create!(
  name: "Place Louis Chazette",
  latitude: 45.7734161,
  longitude: 4.8376788,
  spot_type: "Végétalisation mixte",
  team_id: team1.id,
  is_open: false
)

## new spot elsewhere
# new_spot4 = Spot.create!(
#   name: "Place Gailleton",
#   latitude: 45.7535452,
#   longitude: 4.8327382,
#   spot_type: "Végétalisation mixte",
#   team_id: team1.id,
#   is_open: false
# )

# new_spot5 = Spot.create!(
#   name: "Montée du Télégraphe",
#   latitude: 45.7579594,
#   longitude: 4.8170384,
#   spot_type: "Végétalisation mixte",
#   team_id: team1.id,
#   is_open: false
# )

# new_spot6 = Spot.create!(
#   name: "Montée de l'Observance",
#   latitude: 45.7690504,
#   longitude: 4.81029,
#   spot_type: "Végétalisation mixte",
#   team_id: team1.id,
#   is_open: false
# )

excluded_spot_ids = [spot1.id, spot2.id, new_spot1.id, new_spot2.id, new_spot3.id]

spots = Rails.env == "development" ? spots_data.first(10) : spots_data
spots.each do |spot_data|
  random_team = teams.sample.id
  is_open_probability = rand(100)
  is_open = is_open_probability < 5
  p Spot.create!(
    name: spot_data["properties"]["Name"],
    latitude: spot_data["properties"]["Lat"],
    longitude: spot_data["properties"]["Lon"],
    spot_type: spot_data["properties"]["Type_de_V__g__talisation"],
    team_id: random_team,
    is_open: is_open
  )
end

puts "Creating participations to actions... "

## demo participation trash
participation1 = Participation.create!(
  action_type_id: action4.id,
  user_id: User.pluck(:id).sample,
  upvotes: rand(1..10),
  spot_id: spot1.id,
  created_at: Date.today
)

## demo participation care
participation2 = Participation.create!(
  action_type_id: action3.id,
  user_id: User.pluck(:id).sample,
  upvotes: rand(1..10),
  spot_id: spot2.id,
  created_at: Date.today
)

300.times do
  p Participation.create!(
    action_type_id: ActionType.pluck(:id).sample,
    user_id: User.pluck(:id).sample,
    upvotes: rand(1..10),
    spot: Spot.where.not(id: excluded_spot_ids).sample,
    created_at: rand(6.days).seconds.ago
  )
end

puts "Participations created!"

puts "Creating events..."

event_type1 = EventType.create!(name: "Nouvelle oasis", points: 100)
event_type2 = EventType.create!(name: "Green bombing", points: 200)
event_type3 = EventType.create!(name: "Green raid", points: 300)

event_types = [event_type1, event_type2, event_type3]

100.times do
  p Event.create!(
    spot_id: Spot.pluck(:id).sample,
    occurs_at: rand(15.days).seconds.ago,
    description: "blabla",
    event_type_id: EventType.pluck(:id).sample
  )
end

50.times do
  p Participation.create!(
    event_id: Event.pluck(:id).sample,
    user_id: User.pluck(:id).sample,
    upvotes: rand(1..10),
    spot_id: Spot.pluck(:id).sample,
    created_at: rand(30.days).seconds.ago,
  )
end

puts "Event participations created!"

puts "Finished!"
