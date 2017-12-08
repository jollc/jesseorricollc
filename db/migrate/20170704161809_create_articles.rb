class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :subtitle
      t.string :author
      t.text :content
      t.string :link_text
      t.string :link_url
      t.boolean :archived

      t.timestamps
    end
  end
end
