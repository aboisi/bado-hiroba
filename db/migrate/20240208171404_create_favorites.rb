class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :member_id #「いいね」した会員ID
      t.integer :post_id #「いいね」された投稿のID
      t.timestamps
    end
  end
end
