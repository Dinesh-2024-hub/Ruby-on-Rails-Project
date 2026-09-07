class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :following_relationships,
           class_name: "Follow",
           foreign_key: :follower_id,
           dependent: :destroy

  has_many :followers_relationships,
           class_name: "Follow",
           foreign_key: :following_id,
           dependent: :destroy

  has_many :following,
           through: :following_relationships,
           source: :following

  has_many :followers,
           through: :followers_relationships,
           source: :follower

  validates :username,
            presence: true,
            uniqueness: true,
            length: { minimum: 3, maximum: 20 }

  validates :display_name,
            presence: true,
            length: { maximum: 50 }
end
