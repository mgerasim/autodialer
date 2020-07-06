class AddPrefixContryToConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :configs, :prefix_contry, :integer, :default => 7
  end
end
