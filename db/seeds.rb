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
