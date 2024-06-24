class Post < ApplicationRecord

  has_one_attached :image
  belongs_to :user

  validates :pref, presence: true
  validates :title, presence: true
  validates :body, presence: true

end