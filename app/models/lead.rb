class Lead < ApplicationRecord
  belongs_to :answer, required: false
  belongs_to :employee, required: false
end
