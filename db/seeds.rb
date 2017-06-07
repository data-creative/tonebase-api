# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

instrument = Instrument.where(name: "Guitar").first_or_create
instrument.update_attributes(description: "A musical instrument classified as a fretted string instrument with anywhere from four to 18 strings, usually having six.")

puts instrument.as_json

if Rails.env.development?

  User.destroy_all

  user = User.create({
    email: "avg.joe@gmail.com",
    password: "abc123",
    username: "joe123",
    confirmed: false,
    visible: true,
    role: "User",
    access_level: "Full",
    customer_uuid: "cus_abc123def45678",
    oauth: true,
    oauth_provider: "Google",
    user_profile_attributes:{
      first_name: "Joe",
      last_name: "Averaggi",
      bio: "I love guitar and I'm hoping to get better!",
      image_url: "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg",
      hero_url: "https://my-bucket.s3.amazonaws.com/my-dir/hero-image.jpg",
      birth_year: 1993,
      professions: ["Student"]
    },
    user_music_profile_attributes: {
      guitar_owned: true,
      guitar_models_owned: ["Gibson ABC", "Fender XYZ"],
      fav_composers: ["Bach"],
      fav_performers: ["Talenti"],
      fav_periods: ["Classical", "Contemporary", "Baroque"]
    }
  })

  puts user.as_json

  artist = User.create({
    email: "talenti.pro@gmail.com",
    password: "abc123",
    username: "pro123",
    confirmed: true,
    visible: true,
    role: "Artist",
    access_level: "Full",
    customer_uuid: nil,
    oauth: false,
    oauth_provider: nil,
    user_profile_attributes:{
      first_name: "Talenti",
      last_name: "Pro",
      bio: "My passion. My music",
      image_url: "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg",
      hero_url: "https://my-bucket.s3.amazonaws.com/my-dir/hero-image.jpg",
      birth_year: 1975,
      professions: ["Performer", "Instructor"]
    }
  })

  puts artist.as_json
end
