class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :body
      t.integer :priority
      t.integer :score
      t.string :comments
      t.integer :personal_engagement_list_id

      t.timestamps
    end
  end
end
