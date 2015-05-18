class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.text :name
      t.text :email
      t.integer :question_id

      t.timestamps null: false
    end
  end
end
