class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #trueを返すとログインできる
  def member_status
    if is_active == true
      "有効"
    else
      "退会"
    end
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
