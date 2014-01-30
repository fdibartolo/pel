class Request < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_and_belongs_to_many :recipients, class_name: 'User'

  validates :owner, presence: true

  def add_recipients_and_return_invalid enterprise_ids
    enterprise_ids.uniq!
    invalid_enterprise_ids = []

    enterprise_ids.each do |enterprise_id|
      user = User.find_by(enterprise_id: enterprise_id)
      if user
        self.recipients.push user unless recipient_ids.include? user.id
      else
        invalid_enterprise_ids << enterprise_id
      end
    end
    
    save(validate: false)
    invalid_enterprise_ids
  end
end
