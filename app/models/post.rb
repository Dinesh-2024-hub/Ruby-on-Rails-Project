class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 280 }
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
