class AddIsVoteSupportedToConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :configs, :is_vote_supported, :boolean
  end
end
