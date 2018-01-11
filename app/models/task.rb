class Task < ApplicationRecord
  after_create :read_upload
  attr_accessor :csv_upload
  has_many :contacts
  validates :name, presence: true, length: { maximum: 50 }
  validates :csv_upload, presence: true

  private

  def read_upload
          File.foreach(self.csv_upload.path) {|line|     Rails.logger.info(line)
            @contact = self.contacts.create(phone: line, status: "INSERTED")
          } 
  end
end
