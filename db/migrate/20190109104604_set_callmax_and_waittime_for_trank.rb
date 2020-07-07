class SetCallmaxAndWaittimeForTrank < ActiveRecord::Migration[5.1]
  def change
    Trank.all.each do |trank| 
      trank.callmax = trank.callcount
      trank.save
    end
  end
end
