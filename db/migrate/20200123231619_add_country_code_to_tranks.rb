class AddCountryCodeToTranks < ActiveRecord::Migration[5.1]
  def change
    add_column :tranks, :country_code, :string
  end
end
