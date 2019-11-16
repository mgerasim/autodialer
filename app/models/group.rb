class Group < ApplicationRecord
    has_and_belongs_to_many :tranks

    def shown_tranks
        self.tranks.collect(&:name).join(';')
    end

end
