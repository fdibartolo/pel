class PersonalEngagementList < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :delete_all

  accepts_nested_attributes_for :questions
  
  include ActiveModel::Validations
  validates_with PriorityValidator

  def build_questions_from params
    params.each do |question|
      questions.build(attributes: {
        personal_engagement_list_id: self.id,
        body: question['body'],
        priority: question['priority'].to_i, 
        score: question['score'].to_i
      })
    end 
  end
end
