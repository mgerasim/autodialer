class AddCarouselTypeToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :carousel_type, :integer
  end
end
