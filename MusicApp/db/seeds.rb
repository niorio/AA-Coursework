# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

david = Band.create!(name:"David Bowie")

ziggy = david.albums.create!(title: "Ziggy Stardust", style: "studio")

ziggy.tracks.create!(title:"Five Years", bonus: false, lyrics: "la lah la")
ziggy.tracks.create!(title:"Moonage Daydream", bonus: false)
ziggy.tracks.create!(title:"Sufragette City", bonus: false, lyrics: "down in sufragette city")
ziggy.tracks.create!(title:"Starman", bonus: false)

u2 = Band.create!(name:"U2")
war = u2.albums.create!(title:"War", style:"studio")
