class Task < ApplicationRecord
  default_scope { order(created_at: :desc) }
  attr_accessor :csv_upload
  has_many :contacts, dependent: :delete_all
  validates :name, presence: true, length: { maximum: 50 }
  validates :csv_upload, presence: true
end
