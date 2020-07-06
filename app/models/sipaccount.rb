class Sipaccount < ApplicationRecord

  def title

    "#{number}:#{password}"

  end

end
