class AddSysadminToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sysadmin, :boolean, default: false
    add_index :users, :sysadmin
  end
end
