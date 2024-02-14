class RemoveGroupFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :group, :integer
  end
end
