class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.integer :page_id

      t.datetime :created_at
    end
    add_index :permissions, :user_id
    add_index :permissions, :page_id
  end
end
