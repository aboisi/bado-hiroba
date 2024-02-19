class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #新規登録する際にset_default_avatarメソッドを呼び出す
  before_create :set_default_avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :posts
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :display_name, presence: true

  #プロフィール画像の設定
  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  #会員ステータス
  def member_status
    if is_active == true
      "有効"
    else
      "退会"
    end
  end

  #会員フルネーム
  def full_name
    "#{self.last_name} #{self.first_name}"
  end

   #ゲストログイン
  GUEST_MEMBER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_MEMBER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.last_name = "guest"
      member.first_name = "user"
      member.display_name = "guestuser"
    end
  end

  def guest_member?
    email == GUEST_MEMBER_EMAIL
  end
  
  #会員検索
  def self.looks(search, word)
    if search == "perfect_match"
      @members = User.where("last_name = ? OR first_name = ?", word, word)
    elsif search == "forward_match"
      @members = User.where("last_name LIKE ? OR first_name LIKE ?", "#{word}%", "#{word}%")
    elsif search == "backward_match"
      @members = User.where("last_name LIKE ? OR first_name LIKE ?", "%#{word}", "%#{word}")
    elsif search == "partial_match"
      @members = User.where("last_name LIKE ? OR first_name LIKE ? OR full_name LIKE ?",
                          "%#{word}%", "%#{word}%", "%#{word}%")
    else
      @members = Member.all
    end
  end

  private

   # プロフィール画像の設定

   #profile_imageにアクセスするためのメソッド
  def avatar
    profile_image
  end

  #新規登録するたびに呼び出され、プロフィール画像が設定されていない場合にデフォルト画像を設定する
  def set_default_avatar
    #avatarが(profile_image)が設定されていない場合にdefault_avatar_urlを用いてデフォルトの画像パスを設定する
    self.avatar ||= default_avatar_url
  end

  #デフォルトの画像のパスを指定するためのメソッド
  def default_avatar_url
    ActionController::Base.helpers.asset_path("app/assets/images/no_image.jpg")
  end

end
