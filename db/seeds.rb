# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
usuario = Usuario.new
usuario.email = 'admin@gmail.com'
usuario.password = 'admin123'
usuario.password_confirmation = 'admin123'
usuario.role = 2
usuario.validated = true
usuario.save!
