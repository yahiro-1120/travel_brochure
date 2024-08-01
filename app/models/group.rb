class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, source: :user
  belongs_to :owner, class_name: 'User'
  has_many :permits, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :image

  def get_image
    (image.attached?) ? image: 'no_image.jpg'
  end

  def is_owned_by?(user)
    owner.id == user.id
  end

  def include_user?(user)
    group_users.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Group.where('name LIKE ? OR introduction LIKE ?', "#{content}", "#{content}")
    elsif method == 'forward'
      Group.where('name LIKE ? OR introduction LIKE ?', "#{content}%", "#{content}%")
    elsif method == 'backward'
      Group.where('name LIKE ? OR introduction LIKE ?', "%#{content}", "%#{content}")
    else
      Group.where('name LIKE ? OR introduction LIKE ?', "%#{content}%", "%#{content}%")
    end
  end

end
