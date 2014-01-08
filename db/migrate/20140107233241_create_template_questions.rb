class CreateTemplateQuestions < ActiveRecord::Migration
  def change
    create_table :template_questions do |t|
      t.string :body

      t.timestamps
    end
  end
end
