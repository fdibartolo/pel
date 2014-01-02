class Question < ActiveRecord::Base
  belongs_to :personal_engagement_list

  validates :personal_engagement_list_id, presence: true
  validates :body, presence: true
  validates :score, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
  validates :priority, uniqueness: { scope: :personal_engagement_list_id }
end
