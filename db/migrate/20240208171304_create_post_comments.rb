class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.integer :post_id #ポストID
      t.integer :member_id #会員ID
      t.text :comment #コメント
      t.timestamps
    end
  end
end
