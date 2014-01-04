class AddUserIdToPersonalEngagementList < ActiveRecord::Migration
  def change
    add_column :personal_engagement_lists, :user_id, :integer
  end
end
