# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def user_exists? eid
  User.find_by(enterprise_id: eid)
end

%W[
  fernando.di.bartolo
  heraldo.gimenez
].each do |enterprise_id|
  User.create! enterprise_id: enterprise_id unless user_exists? enterprise_id
end