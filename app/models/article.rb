class Article < ApplicationRecord
  validates :title, :content, presence: true

  dragonfly_accessor :image
end
