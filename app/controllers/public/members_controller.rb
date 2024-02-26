class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:edit, :update, :withdraw]

  def show
    @member = current_member
    @groups = @member.groups.page(params[:page]).per(5)
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    # byebug
    if @member.update(member_params)
      flash[:success] = "登録情報を変更しました。"
      redirect_to my_page_path
    else
      render 'edit'
    end
  end

  def unsubscribe
    @member = current_member
  end

  #退会処理
  def withdraw
    @member = current_member
    #current_memberが持つ、is_activeカラムをfalseにして退会状態にする
    @member.update(is_active: false)
    #セッション情報をすべて削除
    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to root_path
  end

  #いいね一覧
  def favorites
    @member = Member.find(params[:id])
    favorites= Favorite.where(member_id: @member.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end



  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :email, :display_name, :password, :password_confirmation, :profile_image)
  end

  def ensure_guest_member
    @member = current_member
    if @member.guest_member?
      redirect_to my_page_path , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
