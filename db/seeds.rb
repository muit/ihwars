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
Entity.create(type_id: 0, name: "hub", armor: 1000000000) # Almost infinity. This cannot be destroyed
# Resource-production Buildings
Entity.create(type_id: 1, name: "server", armor: 1000)
Entity.create(type_id: 2, name: "bank", armor: 1000)
