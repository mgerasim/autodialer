class Setting < ApplicationRecord
	has_attached_file :google_private_key
 	validates_attachment_content_type :google_private_key, content_type: /\.*\/.*\z/
	
	def initialize(attributes={})
      		super
      		self.outgoing = '/var/spool/asterisk/outgoing'
    end
end
