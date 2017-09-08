# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Wine.destroy_all
puts "Seeding"
Wine.create!(
{
  appelation: "Saint-Emilion Grand Cru Classé",
  domain: "Cadet-Bon",
  year: 2007,
  color: "Rouge",
  stock: 3
}
)
Wine.create!(
{
  appelation: "Sauternes",
  domain: "La Roche Jagu",
  year: 2015,
  color: "Blanc",
  stock: 1
}
)
Wine.create!(
{
  appelation: "Jean-Michel",
  domain: "La Ville Neuve",
  year: 2017,
  color: "Rosé",
  stock: 4
}
)
puts "DOne"
