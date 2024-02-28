class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:edit, :update, :withdraw]

  def show
    @member = current_member
    @groups = @member.groups
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
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
    @groups = current_member.groups
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    @favorite_posts = Post.includes(:group, :member).where(id: favorites)
    # 自分が加入しているグループの投稿のみ表示
    @favorite_posts = @favorite_posts.select { |post| @groups.include?(post.group) }
    @favorite_posts = Kaminari.paginate_array(@favorite_posts).page(params[:page]).per(10)
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
