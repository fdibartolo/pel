class CreateRequisitions < ActiveRecord::Migration
  def change
    create_table :requisitions do |t|
      t.integer :request_id
      t.integer :user_id
      t.integer :personal_engagement_list_id

      t.timestamps
    end
  end
end
