class AddPasswordToTrank < ActiveRecord::Migration[5.1]
  def change
    add_column :tranks, :password, :string
  end
end
