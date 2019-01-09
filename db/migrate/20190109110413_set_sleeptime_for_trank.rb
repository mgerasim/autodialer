class SetSleeptimeForTrank < ActiveRecord::Migration[5.1]
  def change
    Trank.all.each do |trank|
      trank.sleeptime = 1
      trank.save
    end
  end
end
