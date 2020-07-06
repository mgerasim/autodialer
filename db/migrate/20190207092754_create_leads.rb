class CreateLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :leads do |t|
      t.string :phone
      t.string :dialer_status
      t.integer :dialer_attempt
      t.boolean :is_offer_accepted

      t.timestamps
    end
  end
end
