class AddContextToTrank < ActiveRecord::Migration[5.1]
  def change
    add_column :tranks, :context, :string
  end
end
