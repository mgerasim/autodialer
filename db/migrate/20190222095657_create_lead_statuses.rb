class CreateLeadStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :lead_statuses do |t|
      t.attachment :image
      t.string :title
      t.string :name

      t.timestamps
    end
  end
end
