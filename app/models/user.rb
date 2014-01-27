class User < ActiveRecord::Base
  has_many :personal_engagement_lists
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :requests
  
  validates :enterprise_id, presence: true

  def has_role? name
    roles.map(&:name).include? name
  end
end
