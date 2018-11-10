class AddPasswordToConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :configs, :password, :string
  end
end
