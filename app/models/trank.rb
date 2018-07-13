class Trank < ApplicationRecord
    validates :name, presence: true
    validates :waittime, presence: true
    validates :callerid, presence: true
    validates :callcount, presence: true
end
