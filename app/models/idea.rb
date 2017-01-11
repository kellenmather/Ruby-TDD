class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :user_likes, through: :likes, source: :user

  # Validations

  validates :text, :presence => true, length: { minimum: 9 }
end
