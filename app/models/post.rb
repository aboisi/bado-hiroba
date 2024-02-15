class Post < ApplicationRecord
  belongs_to :member
  belongs_to :group
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
end
