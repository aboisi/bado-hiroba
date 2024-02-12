class AddTelephoneNumberToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :telephone_number, :string
  end
end
