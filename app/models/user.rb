class User < ActiveRecord::Base
  has_many :personal_engagement_lists
  
  validates :enterprise_id, presence: true
end
