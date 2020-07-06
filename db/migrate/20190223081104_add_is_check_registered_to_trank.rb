class AddIsCheckRegisteredToTrank < ActiveRecord::Migration[5.1]
  def change
    add_column :tranks, :is_check_registered, :boolean
  end
end
