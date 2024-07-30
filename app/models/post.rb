class Post < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :maps, dependent: :destroy


  validates :pref, presence: true
  validates :title, presence: true
  #validates :address, presence: true



  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where('pref LIKE ? OR title LIKE ?', "#{content}", "#{content}")
    elsif method == 'forward'
      Post.where('pref LIKE ? OR title LIKE ?', "#{content}%", "#{content}%")
    elsif method == 'backward'
      Post.where('pref LIKE ? OR title LIKE ?', "%#{content}", "%#{content}")
    else
      Post.where('pref LIKE ? OR title LIKE ?', "%#{content}%", "%#{content}%")
    end
  end

end