class CreateAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :alerts do |t|
      t.string :content
      t.date :start_date
      t.date :end_date
      t.string :link
      t.text :notes
      t.boolean :archive

      t.timestamps
    end
  end
end
