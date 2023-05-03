# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.destroy_all
Artwork.destroy_all

User.create!(name: 'Paulo')
User.create!(name: 'Chris')
User.create!(name: 'Mike')

Artwork.create!(title: 'mona lisa',image_url: 'lourve.com', artist_id:1)
Artwork.create!(title: 'Self Portrait',image_url: 'MOMA.com', artist_id:2)
Artwork.create!(title: 'Self Portrait',image_url: 'google.com', artist_id:3)
Artwork.create!(title: 'Stary Night',image_url: 'VanGogh.com', artist_id:1)
