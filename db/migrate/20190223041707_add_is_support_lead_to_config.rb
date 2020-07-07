class AddIsSupportLeadToConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :configs, :is_support_employee, :boolean
  end
end
