class AddIsSupportCallToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :is_support_call, :boolean
  end
end
