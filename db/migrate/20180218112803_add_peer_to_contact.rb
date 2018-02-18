class AddPeerToContact < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :peer, :string
  end
end
