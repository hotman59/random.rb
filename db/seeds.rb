# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



a=[
  "Guillaume",
  "Sophie",
  "Jade",
  "Philippe",
  "Anas",
  "Najib",
  "Marc",
  "Antoine",
  "Thierry",
  "Anthony",
  "Thomas",
  "Vincent",
  "Alexis",
  "Julie",
  "Sabrina",
  "Bertrand",
  "Naïma",
  "François",
  "Othman",
  "Caroline",
  "Didier",
  "Thanh",
  "Manoël"

]
23.times do |i|
  b = Person.create(
  name: "#{a[i]}",
  email: "#{a[i]}@exemple.com",
  tel: 660067190,
  sensei: false,
  )

end
