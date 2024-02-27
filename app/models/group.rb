class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :members,through: :group_users, source: :member
  has_many :posts
  belongs_to :region

  validates :name, presence: true
  validates :introduction, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true

  #group_usersテーブルにおいて、指定されたmember_idを持つレコードが存在するか確認する
  def includeUser?(member)
    group_users.exists?(member_id: member.id)
  end

  #グループ画像設定
  has_one_attached :group_image

  def get_group_image(width,height)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      group_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    group_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.looks(search, word)
    case search
    when "perfect_match"
      @group = Group.where("name LIKE?", "#{word}")
    when "partial_match"
      @group = Group.where("name LIKE?", "%#{word}%")
    else
      @group = Group.none
    end
  end

end
