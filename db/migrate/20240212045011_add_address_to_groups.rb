class AddAddressToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :address, :string
  end
end
