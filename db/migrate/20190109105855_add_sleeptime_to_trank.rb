class AddSleeptimeToTrank < ActiveRecord::Migration[5.1]
  def change
    add_column :tranks, :sleeptime, :integer
  end
end
