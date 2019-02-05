require 'csv'

class Asteriskcdr < ActiveRecord::Base
#  establish_connection(:asteriskcdrdb)
  self.table_name = "cdr"
  self.primary_key = "clid"

  default_scope { order(calldate: :desc) }

  def self.to_csv
	attributes = %w{shown_date_created_at shown_time_created_at userfield billsec disposition}
	
	CSV.generate({:headers => false, :col_sep => ';'}) do |csv|
	    
	    all.each do |cdr|
	        csv << attributes.map{ |attr| cdr.send(attr) }
	    end
	    
	end
    end

    def shown_date_created_at
        (calldate.localtime).strftime("%Y-%m-%d")
    end

    def shown_time_created_at
        (calldate.localtime).strftime("%H:%M:%S")
    end
	

end
