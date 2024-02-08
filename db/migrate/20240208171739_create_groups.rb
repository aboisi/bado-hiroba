class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :region_id #地域ID
      t.string :name #グループ名
      t.text :introduction #グループ説明
      t.integer :image_id #画像ID
      t.timestamps
    end
  end
end
