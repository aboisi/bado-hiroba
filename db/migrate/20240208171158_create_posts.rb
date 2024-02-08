class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :member_id #会員ID
      t.text :body #投稿本文
      t.timestamps
    end
  end
end
