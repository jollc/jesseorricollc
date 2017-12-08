class AddImagesToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :image_uid, :string
  end
end
