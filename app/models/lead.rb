class Lead < ApplicationRecord
  belongs_to :answer, required: false
  belongs_to :employee, required: false
  default_scope { order(created_at: :desc) }
end
