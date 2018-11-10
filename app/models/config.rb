class Config < ApplicationRecord
  before_save :encrypt_password
  def encrypt_password
 	if (self.password != "")
		self.password_encrypted = Digest::MD5::hexdigest(self.password)
        	self.password = nil
	end
  end
end
