class Spool < ApplicationRecord
  belongs_to :outgoing
  belongs_to :trank
end
