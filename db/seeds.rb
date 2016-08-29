require "faker"
environment_seed_file = File.join(Rails.root, 'db', 'seeds', "#{Rails.env}.rb")


UserSkill.destroy_all
Skill.destroy_all
Category.destroy_all
User.destroy_all

User.create(
    email: "john@gmail.com",
    password: "blabla",
    first_name: "John",
    last_name: "Begood",
    status: false,
    gender: "male",
    work_place: "plopin",
    birthday: Date.today,
    bio: "plout"
  )
User.create(
    email: "paul@gmail.com",
    password: "blabla",
    first_name: "Paul",
    last_name: "Begood",
    status: false,
    gender: "male",
    work_place: "plopin",
    birthday: Date.today,
    bio: "plout"
  )
User.create(
    email: "joe@gmail.com",
    password: "blabla",
    first_name: "Joe",
    last_name: "Begood",
    status: false,
    gender: "male",
    work_place: "plopin",
    birthday: Date.today,
    bio: "plout"
  )
User.create(
    email: "Bob@gmail.com",
    password: "blabla",
    first_name: "Bob",
    last_name: "Begood",
    status: false,
    gender: "male",
    work_place: "plopin",
    birthday: Date.today,
    bio: "plout"
  )
User.create(
    email: "mona@gmail.com",
    password: "blabla",
    first_name: "mona",
    last_name: "Begood",
    status: false,
    gender: "male",
    work_place: "plopin",
    birthday: Date.today,
    bio: "plout"
  )
User.create(
    email: "loan@gmail.com",
    password: "blabla",
    first_name: "Loan",
    last_name: "Begood",
    status: false,
    gender: "male",
    work_place: "plopin",
    birthday: Date.today,
    bio: "plout"
  )
User.create(
    email: "popi@gmail.com",
    password: "blabla",
    first_name: "Popi",
    last_name: "Begood",
    status: false,
    gender: "male",
    work_place: "plopin",
    birthday: Date.today,
    bio: "plout"
  )

Connection.create!(status: "connected", guest_id: 1, host_id: 2)
Connection.create!(status: "connected", guest_id: 1, host_id: 3)
Connection.create!(status: "connected", guest_id: 4, host_id: 1)
Connection.create!(status: "connected", guest_id: 1, host_id: 5)
Connection.create!(status: "connected", guest_id: 2, host_id: 7)
Connection.create!(status: "connected", guest_id: 7, host_id: 5)
Connection.create!(status: "connected", guest_id: 6, host_id: 7)


# Categories and skills
cat_skills = [
  {
    name: "Programming",
    skills:
    [
      {name: 'Ruby'},
      {name: 'Html'},
      {name: 'JS'},
      {name: 'CSS'},
      {name: 'Python'},
    ],
    photo_url: "http://jerico.strasociwebmeosis1.fr/meoblog/wp-content/uploads/sites/9/2016/03/logiciel-de-programmation.jpg"
  },
  {
    name: "Management",
    skills:
    [
      {name: 'skill_manag1'},
      {name: 'skill_manag2'},
      {name: 'skill_manag3'}
    ],
    photo_url: "http://www.projectmanagers.net/i/wp-content/uploads/2013/05/bigstock-Business-Team-Meeting-at-Sunse-62229413.jpg"
  },
  {
    name: "Database",
    skills:
    [
      {name: 'skill_data1'},
      {name: 'skill_data2'},
      {name: 'skill_data3'},
      {name: 'skill_data4'}
    ],
    photo_url: "http://bigdata.socuumcas.net/images/daat.jpg"
  },
  {
    name: "Digital",
    skills:
    [
      {name: 'skill_digi1'},
      {name: 'skill_digi2'},
      {name: 'skill_digi3'}
    ],
    photo_url: "http://i.huffpost.com/gen/2050946/images/o-DIGITAL-MARKETING-facebook.jpg"
  },
  {
    name: "Graphism",
    skills:
    [
      {name: 'skill_graph1'},
      {name: 'skill_graph2'},
      {name: 'skill_graph3'},
      {name: 'skill_graph4'},
      {name: 'skill_graph5'},
      {name: 'skill_graph6'},
      {name: 'skill_graph7'}
    ],
    photo_url: "http://www.lasalopette.net/wordpress/wp-content/uploads/2014/11/1517407_10154944120615601_2145974816554658412_n.jpg"
  },
  {
    name: "Industry",
    skills:
    [
      {name: 'skill_indus1'},
      {name: 'skill_indus2'},
      {name: 'skill_indus3'},
      {name: 'skill_indus4'}
    ],
    photo_url: "https://data.motor-talk.de/data/galleries/0/188/5281/57789828/rueckrufe-usa-5076501119952349315.jpg"
  },
  {
    name: "Photography",
    skills:
    [
      {name: 'skill_photo1'},
      {name: 'skill_photo2'},
      {name: 'skill_photo3'}
    ],
    photo_url: "http://www.mon-savoir.fr/wp-content/uploads/2015/04/histoire-photographie-apprendre-expose-1024x678.jpg"
  },
  {
    name: "Finance",
    skills:
    [
      {name: 'skill_finance1'},
      {name: 'skill_finance2'},
      {name: 'skill_finance3'},
      {name: 'skill_finance4'},
      {name: 'skill_finance5'}
    ],
    photo_url: "http://static.memrise.com/uploads/course_photos/3146044000150629230223.jpg"
  },
  {
    name: "Conseil",
    skills:
    [
      {name: 'skill_cons1'},
      {name: 'skill_cons2'},
      {name: 'skill_cons3'}
    ],
    photo_url: "http://www.fca-conseils.com/wp-content/uploads/2015/11/audit-conseil.jpg?quality=100.3016013118360"
  },
  {
    name: "Architecture",
    skills:
    [
      {name: 'skill_arch1'},
      {name: 'skill_arch2'},
      {name: 'skill_arch3'},
      {name: 'skill_arch4'}
    ],
    photo_url: "http://designmag.fr/wp-content/uploads/2015/12/architecture-contemporaine-maison-design.jpg"
  },
]

def seed_icon(file_name)
  "skill_icons/#{file_name}.svg"
end

cat_skills.each do |category_data|
  category = Category.create(name: category_data[:name], photo_url: category_data[:photo_url])
  category_data[:skills].each do |attributes|
    attributes[:icon] = seed_icon(attributes[:name].downcase + '_icon')
    attributes[:category] = category
    Skill.create(attributes)
  end
end



# connection_status
connection_types = [
  "friend",
  "godfather",
  "recommended",
  "connected",
  "suggested"
]


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
    type_partner: ["afterwork", "café", "lunch snack", "salad bar",  "restaurant"].sample,
    pax: Faker::Number.number(2), # balance 2 digits
    user: partner
  )
end



#test
city_data1 = Faker::Address.fr_zip_and_city_in_departement(33)
zip1 = city_data1[0]
city1 = city_data1[1]
address1 = "#{Faker::Address.fr_street_name} #{zip1} #{city1}"
city_data2 = Faker::Address.fr_zip_and_city_in_departement(33)
zip2 = city_data2[0]
city2 = city_data2[1]
address2 = "#{Faker::Address.fr_street_name} #{zip2} #{city2}"
partner = User.create(
  email: "parv@gmail.com",
  password: "123123",
  first_name: "toto",
  last_name: "junior",
  status: true,
  gender: "male",
  work_place: address1,
  birthday: Faker::Date.backward(60),
  bio: "mysterieux toto"
  )
p = Place.create(
  name: "Chez toto",
  address: address2,
  description: "totoland",
  phone_number: "060305",
  type_partner: "café",
  pax: 1,
  user: partner
)
Meeting.create(
  guest_review: Faker::Superhero.power,
  host_review: Faker::Superhero.power,
  date: Faker::Date.between(300.days.ago, Date.today),
  connection: Connection.all.sample,
  place: p
)


User.last.places.first.availabilities.create(min_day: "Monday", max_day: "Sunday", min_time: Time.now, max_time: Time.now)

