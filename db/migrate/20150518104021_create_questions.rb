class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :question
      t.integer :author_id
      t.text :flaws, array: true, default: []

      t.timestamps null: false
    end
  end
end
