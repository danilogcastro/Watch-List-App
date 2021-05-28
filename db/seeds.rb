# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

Movie.destroy_all if Rails.env.development?

puts "Seeding..."

25.times do

  url = "http://tmdb.lewagon.com/movie/top_rated?page=#{(1..100).to_a.sample}"
  movies_serialized = URI.open(url).read
  movies = JSON.parse(movies_serialized)

  movies["results"].each do |movie|
  new_movie = Movie.new(
    title: movie["original_title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
    rating: movie["vote_average"]
    )
    new_movie.save
    puts "#{new_movie.id} - #{new_movie.title}"
  end

end


puts "All done!"
