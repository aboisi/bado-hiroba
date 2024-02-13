Rails.application.routes.draw do

  #管理者用
  #URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  #会員用
  #URL /members/sign_in ...
  devise_for :members, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  #ログアウト
  devise_scope :member do
    get '/members/sign_out' => 'public/sessions#destroy'
  end

  #管理者側
  namespace :admin do
    #トップページ
    root to: "homes#top"
    #検索
    get "search" => "searches#search"
    #会員
    resources :members, only: [:index, :show, :edit, :update]
    #グループ(destroyアクション以外のルーティングを生成)
    resources :groups, except: [:destroy]
    #地域
    resources :regions, only: [:index, :edit, :create, :update]
  end

  #会員側
  scope module: :public do
    #トップページ
    root to: "homes#top"
    #アバウトページ
    get "/about"=>"homes#about"
    #会員 [登録情報、登録情報編集、登録情報更新、退会確認、退会処理（ステータス）]
    get 'members/my_page' => 'members#show', as: 'my_page'
    get 'members/information/edit' => 'members#edit', as: 'edit_information'
    patch 'members/information' => 'members#update', as: 'update_information'
    get 'members/unsubscribe' => 'members#unsubscribe', as: 'unsubscribe'
    patch 'members/withdraw' => 'members#withdraw', as: 'withdraw'
    #ポスト
    resources :posts, only: [:index, :show, :edit, :destroy, :update]
    #グループ
    resources :groups, only: [:show, :destroy] do
      #グループ参加ルーティング
      get "join" => "groups#join"
    end
    #グループメンバー
    resources :group_members, only: [:index, :destroy]
    #地域
    resources :regions, only: [:index]
    #コメント
    resources :post_comments, only: [:create, :destroy]
    #いいね
    resource :favorites, only: [:create, :destroy]
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
