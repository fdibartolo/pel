class PersonalEngagementList < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :delete_all

  include ActiveModel::Validations
  validates_with PriorityValidator
end
