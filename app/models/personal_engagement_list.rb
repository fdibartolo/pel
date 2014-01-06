class PersonalEngagementList < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :delete_all

  accepts_nested_attributes_for :questions
  
  include ActiveModel::Validations
  validates_with PriorityValidator
end
