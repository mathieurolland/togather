require "faker"
environment_seed_file = File.join(Rails.root, 'db', 'seeds', "#{Rails.env}.rb")


UserSkill.destroy_all
Skill.destroy_all
Category.destroy_all
User.destroy_all

def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

def fake_address_gironde
  city_data = Faker::Address.fr_zip_and_city_in_departement(33)
  zip = city_data[0]
  city = city_data[1]
  address = "#{Faker::Address.fr_street_name} #{zip} #{city}"
end

image_users = [
"https://organicthemes.com/demo/profile/files/2012/12/profile_img.png",
"http://cdn.business2community.com/wp-content/uploads/2014/04/profile-picture.jpg",
"https://profile.microsoft.com/regsysprofilecenter/Images/personal_info.jpg",
"https://dealermesh.com/images/profile/2219225-austin-carr-profile.jpg",
"https://www.google.com/intl/fr_ALL/+/images/learnmore/hero/hero-profile.jpg",
"https://justinjackson.ca/wp-content/uploads/2008/08/justin-jackson-profile-smile-selfie.jpg",
"http://54.165.17.179/assets/images/people/tiles/michael-wilson.jpg",
"https://www.google.com/+/images/learnmore/getstarted/feat-profile.png",
"http://www.fine-arts-print.com/wp-content/uploads/2014/10/Martin-Profile.jpg",
"https://d34jodf30bmh8b.cloudfront.net/pictures/5379/5379/profile-8ece7aa8e2cca9ded000c792905d280a.jpg",
"https://www.scheller.gatech.edu/thumb/width/600/cropratio/1:1/pix/directory/xmulford_chuck_profile.jpg.pagespeed.ic.BrKpOe4a3L.jpg",
"http://static6.businessinsider.com/image/52c96f6269beddb8064f26d4-480/woman-profile-photo.png",
"http://i.dailymail.co.uk/i/pix/2014/03/16/article-0-1C55199D00000578-408_306x423.jpg",
"http://lovefromabroad.com/wp-content/uploads/avatars/1/f47387602c85e8c9d34c31e15f9b005a-bpthumb.jpg",
"http://i.dailymail.co.uk/i/pix/2010/05/28/article-1282157-09CB6825000005DC-291_468x392.jpg",
"https://blog.photofeeler.com/wp-content/uploads/2016/02/tips-that-make-men-women-look-more-attractive-in-dating-profile-photos.jpg",
"https://c.fastcompany.net/multisite_files/fastcompany/profile/3003174-photo-150923-pratt-portraits-152large-jpeg.jpg",
"https://urbanasian.files.wordpress.com/2013/04/aa-upload1.jpg",
"http://67.media.tumblr.com/2b2ca42ec1f3bf18a407feee335d9a59/tumblr_mj8siqRn2N1qd9dz2o1_500.jpg",
"http://www.littlegatepublishing.com/wp-content/uploads/2013/11/Jack-Slater-Profile.jpg",
"http://i2.cdscdn.com/pdt2/8/2/6/1/700x700/10icu05d826/rw/roberto-cavalli-costume-homme.jpg",
"http://i2.cdscdn.com/pdt2/1/1/8/1/700x700/jasonpm2118/rw/pascal-morabito-costume-homme.jpg",
"http://i2.cdscdn.com/pdt2/1/9/9/1/700x700/1801941199/rw/pierre-cardin-costume-homme.jpg",
"http://static.bonnesaffairesdunet.com/ecommercio/images/boutique/article/article_1406831518.jpg",
"http://i2.cdscdn.com/pdt2/3/6/2/1/700x700/mp02024362/rw/2015-nouvelle-robe-tailleur-femme-sans-manches-jup.jpg",
"http://images.helline.fr/asset/heine/mmo/hv_format_mouseover_zoom/7688359/PATRIZIA-DINI-Veste-de-tailleur-femme-style-basique-2-boutons-ecru.jpg"
]


loan = User.create( email: "loan@gmail.com", password: "blabla", first_name: "Loan", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[0])
alex = User.create( email: "alex@gmail.com", password: "blabla", first_name: "Alex", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[1])
greg = User.create( email: "greg@gmail.com", password: "blabla", first_name: "Greg", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[9])
arthur = User.create( email: "arthur@gmail.com", password: "blabla", first_name: "Arthur", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[3])
louis = User.create( email: "louis@gmail.com", password: "blabla", first_name: "Louis", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[5])
pauline = User.create( email: "pauline@gmail.com", password: "blabla", first_name: "Pauline", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[4])
jacques = User.create( email: "jacques@gmail.com", password: "blabla", first_name: "Jacques", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[6])
marion = User.create( email: "marion@gmail.com", password: "blabla", first_name: "Marion", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[7])
paul = User.create( email: "paul@gmail.com", password: "blabla", first_name: "Paul", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[8])
laurianne = User.create( email: "laurianne@gmail.com", password: "blabla", first_name: "Laurianne", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[2])
elo = User.create( email: "elo@gmail.com", password: "blabla", first_name: "Elo", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[11])
michael = User.create( email: "michael@gmail.com", password: "blabla", first_name: "Michael", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[10])
lea = User.create( email: "lea@gmail.com", password: "blabla", first_name: "Lea", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[12])
popi = User.create( email: "popi@gmail.com", password: "blabla", first_name: "Popi", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[18])
yann = User.create( email: "yann@gmail.com", password: "blabla", first_name: "Yann", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[14])
marie = User.create( email: "marie@gmail.com", password: "blabla", first_name: "Marie", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[25])
jose = User.create( email: "jose@gmail.com", password: "blabla", first_name: "Jose", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[16])
yannick = User.create( email: "yannick@gmail.com", password: "blabla", first_name: "Yannick", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[17])
jeanne = User.create( email: "jeanne@gmail.com", password: "blabla", first_name: "Jeanne", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[13])
thomas = User.create( email: "thomas@gmail.com", password: "blabla", first_name: "Thomas", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[19])
julien = User.create( email: "julien@gmail.com", password: "blabla", first_name: "Julien", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[20])
raph = User.create( email: "raph@gmail.com", password: "blabla", first_name: "Raph", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand,bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[21])
mathilde = User.create( email: "mathilde@gmail.com", password: "blabla", first_name: "Mathilde", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[23])
jonathan = User.create( email: "jonathan@gmail.com", password: "blabla", first_name: "Jonathan", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[22])
mona = User.create( email: "mona@gmail.com", password: "blabla", first_name: "Mona", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[24])
math = User.create( email: "math@gmail.com", password: "blabla", first_name: "Math", last_name: Faker::Name.last_name, status: false, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "#{Faker::Educator.university}: #{Faker::Educator.course}", photo_url: image_users[15])

c1 = Connection.create!(status: "connected", guest: math, host: loan)
Connection.create!(status: "connected", guest: math, host: mona)
Connection.create!(status: "connected", guest: math, host: jonathan)
Connection.create!(status: "connected", guest: math, host: julien)
Connection.create!(status: "connected", guest: math, host: louis)
c2 = Connection.create!(status: "connected", guest: loan, host: thomas)
c3 = Connection.create!(status: "connected", guest: loan, host: jeanne)
Connection.create!(status: "connected", guest: loan, host: jose)
Connection.create!(status: "connected", guest: loan, host: yannick)
Connection.create!(status: "connected", guest: loan, host: arthur)
Connection.create!(status: "connected", guest: loan, host: mona)
c4 = Connection.create!(status: "connected", guest: louis, host: arthur)
Connection.create!(status: "connected", guest: louis, host: raph)
Connection.create!(status: "connected", guest: louis, host: mathilde)
Connection.create!(status: "connected", guest: louis, host: greg)
Connection.create!(status: "connected", guest: louis, host: julien)
Connection.create!(status: "connected", guest: julien, host: paul)
Connection.create!(status: "connected", guest: julien, host: raph)
Connection.create!(status: "connected", guest: julien, host: mathilde)
Connection.create!(status: "connected", guest: julien, host: marion)
Connection.create!(status: "connected", guest: jonathan, host: paul)
Connection.create!(status: "connected", guest: jonathan, host: laurianne)
Connection.create!(status: "connected", guest: jonathan, host: elo)
c5 = Connection.create!(status: "connected", guest: jonathan, host: arthur)
Connection.create!(status: "connected", guest: jonathan, host: michael)
Connection.create!(status: "connected", guest: mona, host: lea)
Connection.create!(status: "connected", guest: mona, host: popi)
Connection.create!(status: "connected", guest: mona, host: yann)
Connection.create!(status: "connected", guest: mona, host: marie)
c6 = Connection.create!(status: "connected", guest: greg, host: arthur)
Connection.create!(status: "connected", guest: greg, host: alex)
Connection.create!(status: "connected", guest: greg, host: pauline)
Connection.create!(status: "connected", guest: greg, host: raph)
Connection.create!(status: "connected", guest: mathilde, host: raph)
Connection.create!(status: "connected", guest: mathilde, host: pauline)
Connection.create!(status: "connected", guest: mathilde, host: jacques)
Connection.create!(status: "connected", guest: mathilde, host: marion)

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
      {name: 'Planning'},
      {name: 'Organising'},
      {name: 'Reporting'},
    ],
    photo_url: "http://www.projectmanagers.net/i/wp-content/uploads/2013/05/bigstock-Business-Team-Meeting-at-Sunse-62229413.jpg"
  },
  {
    name: "Graphism",
    skills:
    [
      {name: 'Creativity'},
      {name: 'Typography'},
      {name: 'Design Software'},
      {name: 'Color Theory'},
    ],
    photo_url: "http://www.lasalopette.net/wordpress/wp-content/uploads/2014/11/1517407_10154944120615601_2145974816554658412_n.jpg"
  },
  {
    name: "Architecture",
    skills:
    [
      {name: 'Design Talent'},
      {name: 'Engineering Ability'},
      {name: 'Business Aptitude'},
      {name: 'Social Awareness'}
    ],
    photo_url: "https://data.motor-talk.de/data/galleries/0/188/5281/57789828/rueckrufe-usa-5076501119952349315.jpg"
  },
  {
    name: "Photography",
    skills:
    [
      {name: 'Equipment'},
      {name: 'Editing'},
      {name: 'Marketing'}
    ],
    photo_url: "http://www.mon-savoir.fr/wp-content/uploads/2015/04/histoire-photographie-apprendre-expose-1024x678.jpg"
  },
  {
    name: "Finance",
    skills:
    [
      {name: 'Ability to Communicate'},
      {name: 'Capacity for Innovation'},
      {name: 'Commercial Acumen'},
      {name: 'Analytical Ability'},
    ],
    photo_url: "http://static.memrise.com/uploads/course_photos/3146044000150629230223.jpg"
  }
]

def seed_icon(file_name)
  "skill_icons/#{file_name}.svg".gsub(" ", "")
end

cat_skills.each do |category_data|
  category = Category.create(name: category_data[:name], photo_url: category_data[:photo_url])
  category_data[:skills].each do |attributes|
    attributes[:icon] = seed_icon(attributes[:name] + '_icon')
    attributes[:category] = category
    Skill.create(attributes)
  end
end

User.all.each do |user|
  Skill.all.shuffle[0..9].each do |skill|
    UserSkill.create(skill: skill, user: user)
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

#test
partner = User.create(
  email: "pv@gmail.com",
  password: "123123",
  first_name: "Pierre-incent",
  last_name: "junior",
  status: true,
  gender: "male",
  work_place: fake_address_gironde,
  birthday: Faker::Date.backward(60),
  bio: "mysterieux guy"
  )
p = Place.create(
  name: "La Tupina",
  address: "6 Rue Porte de la Monnaie, 33800 Bordeaux",
  description: "La Rue Gourmande : une autre façon de déambuler",
  phone_number: "05 56 91 56 37",
  type_partner: "Restaurant",
  pax: 1,
  photo_url: "https://u.tfstatic.com/restaurant_photos/184/184/169/612/la-tupina-maison-fredon-b85d7.jpg",
  user: partner
)


c1.meetings.create(
  date: Faker::Date.between(300.days.ago, time_rand),
  connection: Connection.all.sample,
  place: p,
  guest_review: "Soirée très sympathique, au plaisir !"
)

c2.meetings.create(
  date: Faker::Date.between(300.days.ago, time_rand),
  connection: Connection.all.sample,
  place: p,
  host_review: "Je te rappelle pour te filer le contact de Wilhelm."
)

c3.meetings.create(
  date: Faker::Date.between(300.days.ago, time_rand),
  connection: Connection.all.sample,
  place: p,
  host_review: "Conversation intéressante!"
)

c4.meetings.create(
  date: Faker::Date.between(300.days.ago, time_rand),
  connection: Connection.all.sample,
  place: p,
  guest_review: "On se revoie au cluster."
)

c5.meetings.create(
  date: Faker::Date.between(300.days.ago, time_rand),
  connection: Connection.all.sample,
  place: p,
  guest_review: "Possibiités de projets communs"
)

c6.meetings.create(
  date: Faker::Date.between(300.days.ago, time_rand),
  connection: Connection.all.sample,
  place: p,
  guest_review: "C'est ok pour nos réunions hebdomadaires !"
)

min_time = DateTime.httpdate("Mon, 01 Jan 2001 12:00:00 GMT")
max_time = DateTime.httpdate("Sat, 06 Jan 2001 14:00:00 GMT")
User.last.places.first.availabilities.create(min_day: "Monday", max_day: "Saturday", min_time: min_time, max_time: max_time)

min_time = DateTime.httpdate("Mon, 01 Jan 2001 19:00:00 GMT")
max_time = DateTime.httpdate("Sat, 06 Jan 2001 23:00:00 GMT")
User.last.places.first.availabilities.create(min_day: "Monday", max_day: "Saturday", min_time: min_time, max_time: max_time)

# partners
philipe = User.create( email: "philipe@gmail.com", password: "blabla", first_name: "Philipe", last_name: Faker::Name.last_name, status: true, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "plout")
pierre = User.create( email: "pierre@gmail.com", password: "blabla", first_name: "Pierre", last_name: Faker::Name.last_name, status: true, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "plout")
polo = User.create( email: "polo@gmail.com", password: "blabla", first_name: "Polo", last_name: Faker::Name.last_name, status: true, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "plout")
patrick = User.create( email: "patrick@gmail.com", password: "blabla", first_name: "Patrick", last_name: Faker::Name.last_name, status: true, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "plout")
patrice = User.create( email: "patrice@gmail.com", password: "blabla", first_name: "Patrice", last_name: Faker::Name.last_name, status: true, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "plout")
paco = User.create( email: "paco@gmail.com", password: "blabla", first_name: "Paco", last_name: Faker::Name.last_name, status: true, gender: "male", work_place: fake_address_gironde, birthday: time_rand, bio: "plout")
patricia = User.create( email: "patricia@gmail.com", password: "blabla", first_name: "Patricia", last_name: Faker::Name.last_name, status: true, gender: "female", work_place: fake_address_gironde, birthday: time_rand, bio: "plout")
paola = User.create( email: "paola@gmail.com", password: "blabla", first_name: "Paola", last_name: Faker::Name.last_name, status: true, gender: "female", work_place: fake_address_gironde, birthday: time_rand, bio: "plout")
pepita = User.create( email: "pepita@gmail.com", password: "blabla", first_name: "Pepita", last_name: Faker::Name.last_name, status: true, gender: "female", work_place: fake_address_gironde, birthday: time_rand, bio: "plout")
paulette = User.create( email: "paulette@gmail.com", password: "blabla", first_name: "Paulette", last_name: Faker::Name.last_name, status: true, gender: "female", work_place: fake_address_gironde, birthday: time_rand, bio: "plout")

#places
Place.create(
    name: Faker::Company.name,
    address: fake_address_gironde,
    description: "Come to relax after work",
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: "Afterwork",
    pax: 10,
    photo_url: "http://www.leboost.com/images/etablissements/2011/01/31/564/1.originale.jpg",
    user: philipe
  )
Place.create(
    name: Faker::Company.name,
    address: fake_address_gironde,
    description: "Take a break",
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: "Afterwork",
    pax: 12,
    photo_url: "http://irishpubcompany.com/wp-content/uploads/2014/08/Slider-for-pcb.jpg",
    user: pierre
  )
Place.create(
    name: Faker::Company.name,
    address: fake_address_gironde,
    description: "Take a break after work",
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: "Afterwork",
    pax: 12,
    photo_url: "http://centrenav.ca/files/tinymce/uploaded/nc-food-and-beverage-pub.jpg",
    user: pierre
  )
Place.create(
    name: Faker::Company.name,
    address: fake_address_gironde,
    description: "Enjoy a coffee",
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: "Café",
    pax: 16,
    photo_url: "https://surlaterrasseduncafe.files.wordpress.com/2014/06/cropped-cafes-in-montpellier.jpg",
    user: polo
  )
Place.create(
    name: Faker::Company.name,
    address: fake_address_gironde,
    description: "Get your dose of energy with a warm coffee",
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: "Café",
    pax: 14,
    photo_url: "https://actubordelaiseblog.files.wordpress.com/2016/06/patio-restaurant-bordeaux.jpg?w=620",
    user: patrick
  )
Place.create(
    name: Faker::Company.name,
    address: fake_address_gironde,
    description: "Fast service and great quality",
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: "Lunch snack",
    pax: 20,
    photo_url: "https://media-cdn.tripadvisor.com/media/photo-s/08/8e/63/ad/camping-le-verger-fleuri.jpg",
    user: patrice
  )
Place.create(
    name: Faker::Company.name,
    address: fake_address_gironde,
    description: "Take a break",
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: "Lunch snack",
    pax: 20,
    photo_url: "http://www.latableduhuit.fr/wp-content/uploads/2016/03/terrasse_bd-resized.jpg",
    user: patrice
  )
Place.create(
    name: Faker::Company.name,
    address: fake_address_gironde,
    description: "Best qualit lunch ever",
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: "Lunch snack",
    pax: 8,
    photo_url: "https://media-cdn.tripadvisor.com/media/photo-s/02/a3/c2/8a/filename-photo-051-jpg.jpg",
    user: paco
  )
Place.create(
    name: Faker::Company.name,
    address: fake_address_gironde,
    description: "Hot summer, fresh salad",
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: "Salad bar",
    pax: 10,
    photo_url: "https://u.tfstatic.com/restaurant_photos/499/39499/169/612/bar-toit-terrasse-molitor-f7535.jpg",
    user: patricia
  )
Place.create(
    name: Faker::Company.name,
    address: fake_address_gironde,
    description: "Hungry ?",
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: "Salad bar",
    pax: 10,
    photo_url: "http://villa-honegg.ch/media/content/text_image/villa-honegg-restaurant-terrasse.jpg.1150x0_q85.jpg",
    user: patricia
  )
Place.create(
    name: Faker::Company.name,
    address: fake_address_gironde,
    description: "Fresh vegetables and fruits, all bio !",
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: "Salad bar",
    pax: 12,
    photo_url: "http://www.gqmagazine.fr/uploads/images/thumbs/201623/18/buddha_bar_hotel_paris_lounge_bar_le_qu4tre_sizel_437636_1600_1200_jpg_941_jpeg_2922.jpeg_north_600x_white.jpg",
    user: paola
  )
Place.create(
    name: Faker::Company.name,
    address: fake_address_gironde,
    description: "Bon appétit!",
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: "Restaurant",
    pax: 16,
    photo_url: "http://www.thonhotels.be/Thonhotels/Hoteller/Belgia/Thon_Hotel_EU/Restaurant/thon-hotel-eu-restaurant-4.jpg",
    user: pepita
  )
Place.create(
    name: Faker::Company.name,
    address: fake_address_gironde,
    description: "Best restaurant in town",
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: "Restaurant",
    pax: 10,
    photo_url: "https://media-cdn.tripadvisor.com/media/photo-s/03/ac/61/2d/albert-cafe.jpg",
    user: paulette
  )
Place.create(
    name: Faker::Company.name,
    address: fake_address_gironde,
    description: "Traditional specialities",
    phone_number: Faker::PhoneNumber.phone_number,
    type_partner: "Restaurant",
    pax: 10,
    photo_url: "http://www.tourisme-montreal.org/blog/wp-content/uploads/2014/06/terrasse-montreal-boris-bistro.jpg",
    user: paulette
  )
