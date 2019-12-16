class AddPathToVote < ActiveRecord::Migration[5.1]
  def change
    add_column :votes, :path, :string
  end
end
