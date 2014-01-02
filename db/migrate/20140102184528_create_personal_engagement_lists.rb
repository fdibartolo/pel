class CreatePersonalEngagementLists < ActiveRecord::Migration
  def change
    create_table :personal_engagement_lists do |t|

      t.timestamps
    end
  end
end
