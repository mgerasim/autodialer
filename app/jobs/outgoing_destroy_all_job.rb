class OutgoingDestroyAllJob < ApplicationJob
  queue_as :default

  def perform( )
    
    	sql = "DELETE FROM outgoings;"	
	
	results = ActiveRecord::Base.connection.execute( sql )
	
	%x( sudo service Autodial restart )
    
  end
end
