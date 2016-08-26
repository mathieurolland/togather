require "faker"

UserSkill.destroy_all
Skill.destroy_all
Category.destroy_all
User.destroy_all

# Categories and skills
cat_skills = [
  { name: "Management",skills: ["skill_1", "skill_2", "skill_3"],
    photo_url: "http://www.projectmanagers.net/i/wp-content/uploads/2013/05/bigstock-Business-Team-Meeting-at-Sunse-62229413.jpg"
   },
  { name: "Database",skills: ["skill_1", "skill_2", "skill_3"],
    photo_url: "http://bigdata.socuumcas.net/images/daat.jpg"
    },
  { name: "Digital",skills: ["skill_1", "skill_2", "skill_3"],
    photo_url: "http://i.huffpost.com/gen/2050946/images/o-DIGITAL-MARKETING-facebook.jpg"
    },
  { name: "Graphism",skills: ["skill_1", "skill_2", "skill_3"],
    photo_url: "http://www.lasalopette.net/wordpress/wp-content/uploads/2014/11/1517407_10154944120615601_2145974816554658412_n.jpg"
    },
  { name: "Management",skills: ["skill_1", "skill_2", "skill_3"],
    photo_url: "http://www.projectmanagers.net/i/wp-content/uploads/2013/05/bigstock-Business-Team-Meeting-at-Sunse-62229413.jpg"
    },
  { name: "Programmation",skills: ["skill_1", "skill_2", "skill_3"],
    photo_url: "http://jerico.strasociwebmeosis1.fr/meoblog/wp-content/uploads/sites/9/2016/03/logiciel-de-programmation.jpg"
    },
  { name: "Industry",skills: ["skill_1", "skill_2", "skill_3"],
    photo_url: "https://data.motor-talk.de/data/galleries/0/188/5281/57789828/rueckrufe-usa-5076501119952349315.jpg"
    },
  { name: "Photography",skills: ["skill_1", "skill_2", "skill_3"],
    photo_url: " http://dotcommate.com/wp-content/uploads/2015/05/websites-for-photographers.jpg"
    },
  { name: "Finance",skills: ["skill_1", "skill_2", "skill_3"],
    photo_url: "http://static.memrise.com/uploads/course_photos/3146044000150629230223.jpg"
    },
  { name: "Conseil",skills: ["skill_1", "skill_2", "skill_3"],
    photo_url: "http://www.fca-conseils.com/wp-content/uploads/2015/11/audit-conseil.jpg?quality=100.3016013118360"
    },
  { name: "Architecture",skills: ["skill_1", "skill_2", "skill_3"],
    photo_url: "http://dceez.com/images/img8/architecture-drawing-design-decorating-9.jpg"
    },
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
  city_data = Faker::Address.fr_zip_and_city_in_departement(33)
  zip = city_data[0]
  city = city_data[1]
  address = "#{Faker::Address.fr_street_name} #{zip} #{city}"
  user = User.create(
    email: Faker::Internet.email,
    password: "blabla",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    status: false,
    gender: ["male", "female"].sample,
    work_place: address,
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
50.times do |i|
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
10.times do
  city_data1 = Faker::Address.fr_zip_and_city_in_departement(33)
  zip1 = city_data1[0]
  city1 = city_data1[1]
  address1 = "#{Faker::Address.fr_street_name} #{zip1} #{city1}"
  city_data2 = Faker::Address.fr_zip_and_city_in_departement(33)
  zip2 = city_data2[0]
  city2 = city_data2[1]
  address2 = "#{Faker::Address.fr_street_name} #{zip2} #{city2}"
  partner = User.create(
    email: Faker::Internet.email,
    password: Faker::Internet.password(8),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    status: true,
    gender: ["male", "female"].sample,
    work_place: address1,
    birthday: Faker::Date.backward(60),
    bio: Faker::Lorem.paragraph
    )
    Place.create(
      name: Faker::Company.name,
      address: address2,
      description: Faker::Company.catch_phrase,
      phone_number: Faker::PhoneNumber.phone_number,
      type_partner: ["restaurant", "café", "afterwork", "lunch snack", "salad bar"].sample,
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

#test
# partner = User.create(
#   email: "parv@gmail.com",
#   password: "123123",
#   first_name: "toto",
#   last_name: "junior",
#   status: true,
#   gender: "male",
#   work_place: "rue des mimosas",
#   birthday: Faker::Date.backward(60),
#   bio: "mysterieux toto"
#   )
#   p = Place.create(
#     name: "Chez toto",
#     address: "ici",
#     description: "totoland",
#     phone_number: "060305",
#     type_partner: "café",
#     pax: 1,
#     user: partner
#     )
# Meeting.create(
#   guest_review: Faker::Superhero.power,
#   host_review: Faker::Superhero.power,
#   date: Faker::Date.between(300.days.ago, Date.today),
#   connection: Connection.all.sample,
#   place: p
#   )

# Message
10.times do
  meeting = Meeting.all.sample
    Message.create(
      content: Faker::StarWars.quote,
      meeting: Meeting.all.sample,
      user: [meeting.connection.guest, meeting.connection.host].sample
      )
end
