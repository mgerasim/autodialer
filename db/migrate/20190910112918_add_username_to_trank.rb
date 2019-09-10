class AddUsernameToTrank < ActiveRecord::Migration[5.1]
  def change
    add_column :tranks, :username, :string
  end
end
