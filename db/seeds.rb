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
BuildingType.create(type_id: 0, name: "Hub",        cost: 1102,   construction_time: 300,   armor: 10000, productsxMinute: 0,  unique: true,  description: "[STILL NOT IMPLEMENTED] The hub is the heart of your base. Upgrading its level will make building faster.")
BuildingType.create(type_id: 1, name: "Server",     cost: 74554,  construction_time: 86400, armor: 800,   productsxMinute: 1,  unique: false, description: "[STILL NOT IMPLEMENTED] The server generates ping. The ping will help your units to win the attacks, giving them a clear advantage due to the hacking technologies.")
BuildingType.create(type_id: 2, name: "Bank",       cost: 18566,  construction_time: 1800,  armor: 1000,  productsxMinute: 81, unique: false, description: "The bank is a key building in your base, since it generates the money.")
BuildingType.create(type_id: 3, name: "Factory",    cost: 11899,  construction_time: 900,   armor: 1000,  productsxMinute: 59, unique: false, description: "The factory is a key building in your base, since it generates the materials to build.")
BuildingType.create(type_id: 4, name: "Barracks",   cost: 6577,   construction_time: 1800,  armor: 2000,  productsxMinute: 9,  unique: false, description: "The barracks train the units which fight for you in battle. [STILL NOT IMPLEMENTED] Upgrading its level will make unit training faster.")
BuildingType.create(type_id: 5, name: "Laboratory", cost: 100734, construction_time: 86400, armor: 700,   productsxMinute: 0,  unique: false, description: "[STILL NOT IMPLEMENTED] The Laboratory allows you to investigate to make your units better in battle and your buildings more effective.")
BuildingType.create(type_id: 6, name: "House",      cost: 9855,   construction_time: 1800,  armor: 600,   productsxMinute: 0,  unique: false, description: "Houses are needed for your units to live. Build more if you want to get a bigger army.")

##Entities: 7 types
puts "Creating Entity Types"
EntityType.delete_all
EntityType.create(type_id: 0, name: "Alumno Básico",        cost: 786,   damage: 10,  armor: 10,  range: 5,   description: "The most basic unit, but also the cheaper. This students win battles by outnumbering their enemies.")
EntityType.create(type_id: 1, name: "Alumno Experimentado", cost: 2133,  damage: 15,  armor: 30,  range: 8,   description: "This units have more experience in battle than their basic counterpart, and thus are better in battle.")
EntityType.create(type_id: 2, name: "Mentor con Látigo",    cost: 8455,  damage: 35,  armor: 50,  range: 20,  description: "The whip allows this unit to attack from a moderate distance.")
EntityType.create(type_id: 3, name: "Mentor con Escopeta",  cost: 6712,  damage: 10,  armor: 5,   range: 100, description: "This unit compensates his weak armor and damage with a extremely high range, which allows them to attack several times before their enemies approach them.")
EntityType.create(type_id: 4, name: "Profesor de Testing",  cost: 26355, damage: 54,  armor: 82,  range: 10,  description: "The beta testers have lots of experience finding the weaknesses of a website, and they apply it to destroy their enemy.")
EntityType.create(type_id: 5, name: "Profesor Trabuquero",  cost: 9145,  damage: 35,  armor: 70,  range: 35,  description: "One of the two only units able to attack from a distance, they have a moderate range.")
EntityType.create(type_id: 6, name: "Lady Muriel",          cost: 45575, damage: 170, armor: 340, range: 5,   description: "Lady Muriel is the boss of this game. She is able to kill any other unit in a face to face combat.")
