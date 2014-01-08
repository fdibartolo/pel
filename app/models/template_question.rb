class TemplateQuestion < ActiveRecord::Base
  validates :body, presence: true
end
