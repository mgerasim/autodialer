class Employee < ApplicationRecord
  belongs_to :sipaccount, required: false

  has_many :leads

  def show_sip
    if (sipaccount != nil)
       sipaccount.title
    else
       ""
    end
  end

end
