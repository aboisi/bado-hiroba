class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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

  #現在のパスワードはパラメーターないで不要かつ、パスワードとパスワードの確認を空にした場合、更新されない
  # def update_without_current_password(params, *options)
  #   params.delete(:current_password)

  #   if params[:password].blank? && params[:password_confirmation].blank?
  #     params.delete(:password)
  #     params.delete(:password_confirmation)
  #   end

  #   result = update(params, *options)
  #   clean_up_passwords
  #   result
  # end
end
