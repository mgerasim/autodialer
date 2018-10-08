require 'csv'

class Asteriskcdr < ActiveRecord::Base
  establish_connection(:asteriskcdrdb)
  self.table_name = "cdr"
  self.primary_key = "clid"

  default_scope { order(calldate: :desc) }

  def self.to_csv
	attributes = %w{calldate disposition userfield}
	
	CSV.generate(headers: true) do |csv|
	    csv << attributes
	    
	    all.each do |cdr|
	        csv << attributes.map{ |attr| cdr.send(attr) }
	    end
	    
	end
    end

end
