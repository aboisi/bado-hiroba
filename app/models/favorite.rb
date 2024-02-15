class Favorite < ApplicationRecord
  
  belongs_to :member
  belongs_to :post
  
  #1人のユーザーが1つの投稿に対して重複していいねできないバリデーション(member_idとpost_idが一意)
  validates :member_id, uniqueness: {scope: :post_id}
end
