class AddCallmaxToTrank < ActiveRecord::Migration[5.1]
  def change
    add_column :tranks, :callmax, :integer
  end
end
