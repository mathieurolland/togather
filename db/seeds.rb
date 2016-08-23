require "faker"

UserSkill.destroy_all
Skill.destroy_all
Category.destroy_all
User.destroy_all

# Categories and skills
cat_skills = [
  { name: "Business intelligence",skills: ["un", "deux", "trois"] },
  { name: "Database",skills: ["un", "deux", "trois"] },
  { name: "Digital",skills: ["un", "deux", "trois"] },
  { name: "Graphism",skills: ["un", "deux", "trois"] },
  { name: "Management",skills: ["un", "deux", "trois"] },
  { name: "Programmation",skills: ["un", "deux", "trois"] },
  { name: "Systems",skills: ["un", "deux", "trois"] },
  { name: "Network",skills: ["un", "deux", "trois"] }
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
    password: Faker::Internet.password(6),
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
  "ami",
  "parrain",
  "parrainé",
  "connecté",
  "suggeré"
]

# connections uniques entre deux users
30.times do |i|
  users = User.all.shuffle[0..1]
  print "#{i+1}....."
  begin
    Connection.create!(status: connection_types.sample, guest: users.first, host: users.last)
    puts "worked"
  rescue
    puts "didn't work"
  end
end

# places
10.times do
  partner = User.create(
        email: Faker::Internet.email,
        password: Faker::Internet.password(8),
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        status: false,
        gender: ["male", "female"].sample,
        work_place: "#{Faker::Address.street_address}, #{Faker::Address.city}",
        birthday: Faker::Date.between(300.days.ago, Date.today),
        bio: Faker::Lorem.paragraph
      )

  Place.create(
    name: Faker::Company.name,
    address: "#{Faker::Address.street_address}, #{Faker::Address.city}",
    description: Faker::Beer.name,
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: ["restau", "café", "after work"].sample,
    pax: Faker::Number.number(2), # balance 2 digits
    user: partner
    )
end

# connection uniques entre 1 partner et 1 place
# 30.times do |i|
#   placess = Place.all.shuffle[0..1]
#   print "#{i+1}....."
#   begin
#     Connection.create!(status: connection_types.sample, guest: users.first, host: users.last)
#     puts "worked"
#   rescue
#     puts "didn't work"
#   end
# end





# # 5 meetings
#     # definir connection_id: 1, place: p
# i = 1
# c = 1
# 10.times do
#    meeting = Meeting.create(
#     guest_review: Faker::Lorem.paragraph,
#     host_review: Faker::Lorem.paragraph,
#     date: Faker::Date.between(300.days.ago, Date.today),
#     connection_id: c,
#     place_id: i
#   )
#   i += 1
#   c += 1
# end


# Message.new(content: "trop top", meeting_id: 1, user_id: Connection.guest_id)


