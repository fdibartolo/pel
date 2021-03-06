class Requisition < ActiveRecord::Base
  belongs_to :request
  belongs_to :user

  validates :request, presence: true
  validates :user, presence: true
end
