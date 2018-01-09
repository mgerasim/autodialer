class Task < ApplicationRecord
  has_many :contacts
  validates :name, presence: true, length: { maximum: 15 }
end
