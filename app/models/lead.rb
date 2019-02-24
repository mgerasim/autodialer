class Lead < ApplicationRecord
  belongs_to :answer, required: false
end
