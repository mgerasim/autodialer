class AddTitleToSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :title, :text
  end
end
