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

# LEAVE THIS IN PRODUCTION FOR NOW TO HELP CLIENT APPLICATION ONBOARDING
unless Rails.env.test? #if Rails.env.development?

  #
  # SEED USERS
  #

  User.destroy_all

  # USER
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

  # MORE USERS
  (1..100).to_a.each do |i|
    User.create({email: "another#{i}@tonebase.com", username: "another#{i}", password: "abc123", confirmed: [true, false].sample, visible: true, role: "User", access_level: ["Full", "Limited"].sample})
  end

  # ARTIST
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

  # MORE ARTISTS
  (1..35).to_a.each do |i|
    User.create({
      email: "another.pro#{i}@gmail.com",
      username: "anotherPro#{i}",
      password: "abc123",
      confirmed: [true, false].sample,
      visible: true,
      role: "Artist",
      access_level: "Full",
      user_profile_attributes:{first_name: "Another", last_name: "Pro"}
    })
  end

  # ADMIN
  admin = User.create({
    email: "admin@tonebase.com",
    username: "admin123",
    password: "abc123",
    confirmed: true,
    visible: true,
    role: "Admin",
    access_level: "Full",
    user_profile_attributes:{first_name: "Tony", last_name: "Administrato"}
  })

  puts artist.as_json

  user_ids = User.user.pluck(:id)
  artist_ids = User.artist.pluck(:id)
  puts "#{user_ids.count} USERS, #{artist_ids.count} ARTISTS"

  #
  # FOLLOWS
  #

  150.times do
    UserFollowship.create(user_id: user_ids.sample, followed_user_id: artist_ids.sample)
  end

  puts "#{UserFollowship.count} FOLLOWS"

  #
  # VIDEOS
  #

  9.times do |i|
    video = Video.create({
      user_id: artist_ids.sample,
      instrument_id: instrument.id,
      title: "Finale from Sonata ##{i}",
      description: "The final moments of master composer Maestrelli's most famous piece. Composed in #{1817 + i}.",
      tags: ["borouque", "maestrelli", "g-major"]
    })

    VideoPart.create(video: video, source_url: "https://www.youtube.com/watch?v=abc123", number: 1, duration: 333)

    if i.odd?
      VideoPart.create(video: video, source_url: "https://www.youtube.com/watch?v=def456", number: 2, duration: 333)
      VideoPart.create(video: video, source_url: "https://www.youtube.com/watch?v=ghi789", number: 3, duration: 333)

      VideoScore.create(video: video, image_url: "https://my-bucket.s3.amazonaws.com/my-dir/score-1-image.jpg", starts_at: 25, ends_at: 500)
      VideoScore.create(video: video, image_url: "https://my-bucket.s3.amazonaws.com/my-dir/score-2-image.jpg", starts_at: 750, ends_at: 900)
    end
  end

  video_ids = Video.pluck(:id)

  puts "#{video_ids.count} VIDEOS"
  puts "#{VideoPart.count} VIDEO PARTS"
  puts "#{VideoScore.count} VIDEO SCORES"

  #
  # FAVORITE VIDEOS
  #

  225.times do
    UserFavoriteVideo.create({user_id: user_ids.sample, video_id: video_ids.sample})
  end

  puts "#{UserFavoriteVideo.count} VIDEO FAVORITES"

  #
  # VIEWED VIDEOS
  #

  350.times do
    UserViewVideo.create({user_id: user_ids.sample, video_id: video_ids.sample})
  end

  puts "#{UserViewVideo.count} VIDEO VIEWS"


  #
  # ANNOUNCEMENTS
  #

  Announcement.create(title: "Keep Playing Bros!")

  3.times do |i|
    Announcement.create({
      title: "New Feature #{i}",
      content: "This new feature allows you to do cool things.",
      url: "https://blog.tonebase.com/posts/new-feature-abc",
      image_url: "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg"
    })
  end

  Announcement.create(title: "Fill out our survey please!", url: "https://surveymonkey.com/surveys/abc")

  puts "#{Announcement.count} ANNOUNCEMENTS"

end
