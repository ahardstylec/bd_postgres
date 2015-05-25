class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :question
      t.text :author_name
      t.text :author_email
      t.integer :author_id
      t.text :flaws, array: true, default: []
    end
  end
end
