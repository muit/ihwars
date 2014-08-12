# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## Resources
# Three types of resources: money, materials, ping
Resource.create(type_id: 0, name: "money")
Resource.create(type_id: 1, name: "materials")
Resource.create(type_id: 2, name: "ping")


## Buildings: 6 types
# Basic building. Appears by default when a base is created
Building.create(type_id: 0, name: "hub", armor: 10000) # Almost infinity. This cannot be destroyed
# Resource-production Buildings
Building.create(type_id: 1, name: "server", armor: 1000)
Building.create(type_id: 2, name: "bank", armor: 1000)
Building.create(type_id: 3, name: "factory", armor: 1000)
Building.create(type_id: 4, name: "barracks", armor: 1000)
Building.create(type_id: 5, name: "laboratory", armor: 1000)

##Entities: 7 types
Entity.create(type_id: 0, name: "Alumno Básico", damage: 10, armor: 10, range: 5)
Entity.create(type_id: 1, name: "Alumno Experimentado", damage: 15, armor: 30, range: 8)
Entity.create(type_id: 2, name: "Mentor con Látigo", damage: 35, armor: 50, range: 10)
Entity.create(type_id: 3, name: "Mentor con Escopeta", damage: 30, armor: 30, range: 100)
Entity.create(type_id: 4, name: "Profesor de Testing", damage: 45, armor: 60, range: 10)
Entity.create(type_id: 5, name: "Profesor Trabuquero", damage: 30, armor: 40, range: 35)
Entity.create(type_id: 6, name: "Lady Muriel", damage: 100, armor: 500, range: 5)