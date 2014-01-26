# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def role_exists? name
  Role.find_by(name: name)
end

[
  AdminRole,
  RequestorRole
].each do |name|
  Role.create! name: name unless role_exists? name
end

Role.all.each {|r| r.users.destroy_all}

{
  AdminRole => %w[
    fernando.di.bartolo 
    heraldo.gimenez
  ],
  RequestorRole => %w[
    fernando.di.bartolo 
    heraldo.gimenez
  ],
  '' => %w[
    user1
  ]
}.each do |role_name, enterprise_ids|
  enterprise_ids.each do |enterprise_id|
    user = User.find_by(enterprise_id: enterprise_id) || User.new(enterprise_id: enterprise_id)
    user.roles << Role.find_by(name: role_name) unless role_name.empty?
    user.save!
  end
end
