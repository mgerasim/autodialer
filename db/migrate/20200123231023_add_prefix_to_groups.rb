class AddPrefixToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :prefix, :string
  end
end
