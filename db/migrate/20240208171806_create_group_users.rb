class CreateGroupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_users do |t|
      t.integer :member_id #会員ID
      t.integer :group_id #グループID
      t.timestamps
    end
  end
end
