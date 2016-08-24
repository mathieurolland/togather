require "faker"

UserSkill.destroy_all
Skill.destroy_all
Category.destroy_all
User.destroy_all

# Categories and skills
cat_skills = [
  { name: "Business intelligence",skills: ["skill_1", "skill_2", "skill_3"] },
  { name: "Database",skills: ["skill_1", "skill_2", "skill_3"] },
  { name: "Digital",skills: ["skill_1", "skill_2", "skill_3"] },
  { name: "Graphism",skills: ["skill_1", "skill_2", "skill_3"] },
  { name: "Management",skills: ["skill_1", "skill_2", "skill_3"] },
  { name: "Programmation",skills: ["skill_1", "skill_2", "skill_3"] },
  { name: "Systems",skills: ["skill_1", "skill_2", "skill_3"] },
  { name: "Network",skills: ["skill_1", "skill_2", "skill_3"] }
]

cat_skills.each do |category_data|
  category = Category.create(name: category_data[:name])
  category_data[:skills].each do |name|
    Skill.create({
      name: name,
      category: category
    })
  end
end

#users and user_skills (genre 3 skills/user)
30.times do
  user = User.create(
    email: Faker::Internet.email,
    password: "blabla",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    status: true,
    gender: ["male", "female"].sample,
    work_place: "#{Faker::Address.street_address}, #{Faker::Address.city}",
    birthday: Faker::Date.between(300.days.ago, Date.today),
    bio: Faker::Lorem.paragraph
  )
  3.times do
    user.user_skills.create(
      skill: Skill.all.sample
    )
  end
end

#connection_status
connection_types = [
  "friend",
  "godfather",
  "recommended",
  "connected",
  "suggested"
]

# connections uniques entre deux users
30.times do |i|
  users = User.all.shuffle[0..1]
  begin
  Connection.create!(status: connection_types.sample, guest: users.first, host: users.last)
rescue
  end
end

#recommended_users
20.times do
  RecommendedUser.create(
    email: Faker::Internet.email,
    user:User.all.sample
  )
end

# places
places = []
10.times do
  partner = User.create(
    email: Faker::Internet.email,
    password: Faker::Internet.password(8),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    status: false,
    gender: ["male", "female"].sample,
    work_place: "#{Faker::Address.street_address}, #{Faker::GameOfThrones.city}",
    birthday: Faker::Date.between(300.days.ago, Date.today),
    bio: Faker::Lorem.paragraph
    )
    Place.create(
      name: Faker::Company.name,
      address: "#{Faker::Address.street_address}, #{Faker::GameOfThrones.city}",
      description: Faker::ChuckNorris.fact,
      phone_number: Faker::PhoneNumber.phone_number,
      type_partner: ["restau", "café", "after work"].sample,
      pax: Faker::Number.number(2), # balance 2 digits
      user: partner
      )
end

# meetings
10.times do
  Meeting.create(
    guest_review: Faker::Superhero.power,
    host_review: Faker::Superhero.power,
    date: Faker::Date.between(300.days.ago, Date.today),
    connection: Connection.all.sample,
    place: Place.all.sample
    )
end

# Message
10.times do
  meeting = Meeting.all.sample
    Message.create(
      content: Faker::StarWars.quote,
      meeting: Meeting.all.sample,
      user: [meeting.connection.guest, meeting.connection.host].sample
      )
end
