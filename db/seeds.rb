# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

lib = Library.create(name: 'kylas')

5. times do |i|
  Book.create(title: "book #{i+1}", author: 'pqr', isbn: 123, genre: 'xyz', library_id: lib.id)
end

5. times do |i|
  Student.create(name: "student #{i+1}", address: 'pqr', phone: 1234567891, email: 'abc@gmail.com')
end
