# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## Resources
puts "Creating Resource Types"
ResourceType.delete_all
ResourceType.create(type_id: 0, name: "money")
ResourceType.create(type_id: 1, name: "materials")
ResourceType.create(type_id: 2, name: "ping")


## Buildings: 7 types
puts "Creating Building Types"
BuildingType.delete_all
BuildingType.create(type_id: 0, name: "Hub",        cost: 1102,   construction_time: 300,   armor: 10000, productsxMinute: 0,  unique: true)
BuildingType.create(type_id: 1, name: "Server",     cost: 74554,  construction_time: 86400, armor: 800,   productsxMinute: 1,  unique: false)
BuildingType.create(type_id: 2, name: "Bank",       cost: 18566,  construction_time: 1800,  armor: 1000,  productsxMinute: 81, unique: false)
BuildingType.create(type_id: 3, name: "Factory",    cost: 11899,  construction_time: 900,   armor: 1000,  productsxMinute: 59, unique: false)
BuildingType.create(type_id: 4, name: "Barracks",   cost: 6577,   construction_time: 1800,  armor: 2000,  productsxMinute: 9,  unique: false)
BuildingType.create(type_id: 5, name: "Laboratory", cost: 100734, construction_time: 86400, armor: 700,   productsxMinute: 0,  unique: false)
BuildingType.create(type_id: 6, name: "House",      cost: 9855,   construction_time: 1800,  armor: 600,   productsxMinute: 0,  unique: false)

##Entities: 7 types
puts "Creating Entity Types"
EntityType.delete_all
EntityType.create(type_id: 0, name: "Alumno Básico",        cost: 700, damage: 10,  armor: 10,  range: 5)
EntityType.create(type_id: 1, name: "Alumno Experimentado", cost: 2000, damage: 15,  armor: 30,  range: 8)
EntityType.create(type_id: 2, name: "Mentor con Látigo",    cost: 4500, damage: 35,  armor: 50,  range: 10)
EntityType.create(type_id: 3, name: "Mentor con Escopeta",  cost: 3500, damage: 10,  armor: 5,   range: 100)
EntityType.create(type_id: 4, name: "Profesor de Testing",  cost: 10000, damage: 45,  armor: 60,  range: 10)
EntityType.create(type_id: 5, name: "Profesor Trabuquero",  cost: 9000, damage: 30,  armor: 40,  range: 35)
EntityType.create(type_id: 6, name: "Lady Muriel",          cost: 20000, damage: 100, armor: 200, range: 5)
