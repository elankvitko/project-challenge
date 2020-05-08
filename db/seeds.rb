# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Due to the new relationship between User and Dog, I updated the seed file
users = [
  {
    name: 'Miranda',
    email: 'miranda@miranda.com',
    password: '123456',
    password_confirmation: '123456'
  },
  {
    name: 'Bobby',
    email: 'bobby@bobby.com',
    password: '123456',
    password_confirmation: '123456'
  },
  {
    name: 'Daniel',
    email: 'daniel@daniel.com',
    password: '123456',
    password_confirmation: '123456'
  },
  {
    name: 'Jessica',
    email: 'jessica@jessica.com',
    password: '123456',
    password_confirmation: '123456'
  }
]

dogs = [
  {
    name: 'Bowie',
    description: 'Bowie dances when he walks'
  },
  {
    name: 'Brownie',
    description: 'Brownie only sits pretty'
  },
  {
    name: 'Jax',
    description: '',
  },
  {
    name: 'Jiro',
    description: 'Jiro takes a long time to destroy his toys'
  },
  {
    name: 'Pete',
    description: 'Pete has a best friend named Lua'
  },
  {
    name: 'Bijou',
    description: 'Bijou is the fluffiest of them all'
  },
    {
    name: 'Britta',
    description: 'Britta has two different colored eyes'
  },
  {
    name: 'Noodle',
    description: 'Noodle is an Instagram celebrity'
  },
  {
    name: 'Stella',
    description: 'Stella loves to dig'
  },
  {
    name: 'Tonks',
    description: 'Tonks loves to run'
  },
]

# find_or_create_by! will error out when creating a user so I did it this way.
# SQLite doesn't like the virtual attribute of password
user_ids = users.map { | user | User.find_by(email: user[:email]).try(:id) || User.create!(user).id }

dogs.each_with_index do | dog, idx |
  dog = Dog.find_or_create_by(name: dog[:name], description: dog[:description], user_id: user_ids[idx % 4])
  directory_name = File.join(Rails.root, 'db', 'seed', "#{dog[:name].downcase}", "*")

  Dir.glob(directory_name).each do |filename|
    if !dog.images.any?{|i| i.filename == filename}
      dog.images.attach(io: File.open(filename), filename: filename.split("/").pop)
      sleep 1
    end
  end
end
