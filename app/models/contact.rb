class Contact < ApplicationRecord
  belongs_to :task
  validates :task_id, presence: true
  validates :status, presence: true, length: { maximum: 15 }
  validates :phone, presence: true, length: { maximum: 15 }

  def self.calling
    File.new('/tmp/1', 'w')
  end

end
