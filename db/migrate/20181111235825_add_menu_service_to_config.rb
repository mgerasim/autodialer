class AddMenuServiceToConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :configs, :is_menu_service_showed, :boolean
  end
end
