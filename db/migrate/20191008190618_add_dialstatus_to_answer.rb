class AddDialstatusToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :dialstatus, :string
  end
end
