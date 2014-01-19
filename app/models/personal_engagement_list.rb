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
        score: question['score'].to_i,
        comments: question['comments']
      })
    end 
  end

  def update_questions_from params
    params.each do |question|
      q = questions.select {|k| k.body == question['body']}.first
      q.priority = question['priority'].to_i
      q.score = question['score'].to_i
      q.comments= question['comments']
    end 
  end

  def reset_priorities
    questions.each do |question|
      question.priority = nil
      question.save(validate: false)
    end
  end
end
