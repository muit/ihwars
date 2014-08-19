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
# Basic building. Appears by default when a base is created
BuildingType.create(type_id: 0, construction_time: 300, name: "Hub", armor: 10000, productsxMinute: 0, unique: true) # Almost infinity. This cannot be destroyed
# Resource-production Buildings
BuildingType.create(type_id: 1, construction_time: 86400, name: "Server", armor: 800, productsxMinute: 1, unique: false)
BuildingType.create(type_id: 2, construction_time: 1800, name: "Bank", armor: 1000, productsxMinute: 81, unique: false)
BuildingType.create(type_id: 3, construction_time: 900, name: "Factory", armor: 1000, productsxMinute: 59, unique: false)
BuildingType.create(type_id: 4, construction_time: 1800, name: "Barracks", armor: 2000, productsxMinute: 9, unique: false)
BuildingType.create(type_id: 5, construction_time: 86400, name: "Laboratory", armor: 700, productsxMinute: 0, unique: false)
BuildingType.create(type_id: 6, construction_time: 1800, name: "House", armor: 600, productsxMinute: 0, unique: false)

##Entities: 7 types
puts "Creating Entity Types"
EntityType.delete_all
EntityType.create(type_id: 0, name: "Alumno Básico", damage: 10, armor: 10, range: 5)
EntityType.create(type_id: 1, name: "Alumno Experimentado", damage: 15, armor: 30, range: 8)
EntityType.create(type_id: 2, name: "Mentor con Látigo", damage: 35, armor: 50, range: 10)
EntityType.create(type_id: 3, name: "Mentor con Escopeta", damage: 10, armor: 5, range: 100)
EntityType.create(type_id: 4, name: "Profesor de Testing", damage: 45, armor: 60, range: 10)
EntityType.create(type_id: 5, name: "Profesor Trabuquero", damage: 30, armor: 40, range: 35)
EntityType.create(type_id: 6, name: "Lady Muriel", damage: 100, armor: 200, range: 5)
