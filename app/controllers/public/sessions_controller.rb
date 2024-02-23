# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :member_state, only: [:create]

  #ゲストログイン
  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to root_path, notice: "guestでログインしました。"
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  #ログイン時の遷移先
  def after_sign_in_path_for(resource)
    root_path
  end

  #ログアウト時の遷移先
  def after_sign_out_path_for(resource)
    root_path
  end

  private
  #会員ステータスがアクティブであるかを判断するメソッド
  def member_state
    #[処理1]入力されたemailからアカウントを1件取得
    member = Member.find_by(email: params[:member][:email])
    #[処理2]アカウントを取得できなかった場合、このメソッドを終了する
    return if member.nil?
    #[処理3]取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
    return unless member.valid_password?(params[:member][:password])
    #[処理4]アクティブでない会員に対する処理
      flash[:notice] = "既に退会済みのアカウントです。新規会員登録が必要になります。"
      redirect_to new_member_registration_path unless member.is_active
  end
end
