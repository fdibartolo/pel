class PersonalEngagementList < ActiveRecord::Base
  has_many :questions, dependent: :delete_all

  include ActiveModel::Validations
  validates_with PriorityValidator
end
