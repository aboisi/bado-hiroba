class Favorite < ApplicationRecord

  belongs_to :member
  belongs_to :post

  #1人のユーザーが1つの投稿に対して重複していいねできないバリデーション(member_idとpost_idが一意である)
  validates :member_id, uniqueness: {scope: :post_id}

  def group
    post.group
  end
  
  def favorited_by?(member)
    self.member == member
  end

  # いいねをつけた投稿の取得
  def self.favorite_posts(member, page, per_page) # モデル内での操作を開始
    includes(post: [:group, :member]) # postと関連するgroupとmemberも取得する
      .where(posts: {member_id: member.id }) # ユーザーがいいねしたレコードを絞り込み
      .order(created_at: :desc) # 投稿を作成日時の降順でソート
      .page(page) # ページネーションのため、指定ページに表示するデータを選択
      .per(per_page) # ページごとのデータ数を指定
  end
end
