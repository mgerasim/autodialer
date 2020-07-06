class AddPathToUrl < ActiveRecord::Migration[5.1]
  def change
    add_column :votes, :url, :string
  end
end
