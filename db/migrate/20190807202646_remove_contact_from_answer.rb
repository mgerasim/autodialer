class RemoveContactFromAnswer < ActiveRecord::Migration[5.1]
  def change
    remove_column :answers, :contact, :string
  end
end
