class CreateTweetsTable < ActiveRecord::Migration
  def change
    create_table :tweets do |t| 
      t.integer :user_id
      t.text :content
      t.timestamps :created_at, null: false
      t.timestamps :updated_at, null: false
    end
  end
end
