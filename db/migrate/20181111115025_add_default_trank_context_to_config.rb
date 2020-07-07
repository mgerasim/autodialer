class AddDefaultTrankContextToConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :configs, :default_trank_context, :string
    add_column :configs, :is_trank_context_showed, :boolean
  end
end
