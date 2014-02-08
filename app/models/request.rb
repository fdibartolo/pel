class Request < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :requisitions
  has_many :recipients, through: :requisitions, source: :user

  validates :owner, presence: true

  def add_recipients_and_return_invalid enterprise_ids
    enterprise_ids.uniq!
    invalid_enterprise_ids = []

    enterprise_ids.each do |enterprise_id|
      user = User.find_by(enterprise_id: enterprise_id)
      if user
        add_requisition_for user unless recipient_ids.include? user.id
      else
        invalid_enterprise_ids << enterprise_id
      end
    end
    
    save(validate: false)
    invalid_enterprise_ids
  end

  def requisition_for user
    requisitions.where(user_id: user.id).first
  end

  private
  def add_requisition_for user
    requisitions.build(attributes: { user_id: user.id })
  end
end
