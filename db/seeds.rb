# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
edition = Edition.create(start_date: DateTime.new(2016, 2, 15), end_date: DateTime.new(2016, 5, 8), name: "second")
Week.create(start: DateTime.new(2016, 2, 1), end: DateTime.new(2016, 2, 7), number: -1, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 2, 8), end: DateTime.new(2016, 2, 14), number: 0, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 2, 15), end: DateTime.new(2016, 2, 21), number: 1, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 2, 22), end: DateTime.new(2016, 2, 28), number: 2, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 2, 29), end: DateTime.new(2016, 3, 6), number: 3, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 3, 7), end: DateTime.new(2016, 3, 13), number: 4, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 3, 14), end: DateTime.new(2016, 3, 20), number: 5, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 3, 21), end: DateTime.new(2016, 3, 27), number: 6, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 3, 28), end: DateTime.new(2016, 4, 3), number: 7, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 4, 4), end: DateTime.new(2016, 4, 10), number: 8, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 4, 11), end: DateTime.new(2016, 4, 17), number: 9, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 2, 18), end: DateTime.new(2016, 4, 24), number: 10, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 4, 25), end: DateTime.new(2016, 5, 1), number: 11, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 5, 2), end: DateTime.new(2016, 5, 8), number: 12, edition_id: edition.id)
