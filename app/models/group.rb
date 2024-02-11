class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :members,through: :group_users, source: :member
  
  varidates :name, presence: true
  varidates :introduction, presence: true
  
  #group_usersテーブルにおいて、指定されたmember_idを持つレコードが存在するか確認する
  def includeUser?(member)
    group_users.exists?(member_id: member.id)
  end
end
