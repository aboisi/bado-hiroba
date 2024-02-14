class AddGroupToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :group, :integer
  end
end
