class Asteriskcdr < ActiveRecord::Base
  establish_connection(:asteriskcdrdb)
  self.table_name = "cdr"
  self.primary_key = "clid"
end
