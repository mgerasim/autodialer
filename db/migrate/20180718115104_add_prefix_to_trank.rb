class AddPrefixToTrank < ActiveRecord::Migration[5.1]
  def change
    add_column :tranks, :prefix, :string, default: ""
  end
end
