class Contact < ApplicationRecord
  after_initialize  { self.phone = phone.gsub(/[^0-9A-Za-z]/, '').gsub(/\r\n?/, "\n").gsub(/\W/, '') }
  default_scope { order(created_at: :desc) }
  belongs_to :task
  validates :task_id, presence: true
  validates :status, presence: true, length: { maximum: 15 }
  validates :phone, presence: true, length: { maximum: 15 }

  def self.calling
    File.new('/tmp/1', 'w')
  end

end
