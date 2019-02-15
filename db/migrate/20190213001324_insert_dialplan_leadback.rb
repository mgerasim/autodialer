class InsertDialplanLeadback < ActiveRecord::Migration[5.1]
  def change
    Dialplan.create(:title => 'Расширенный выполняет соединением с оператором ', :name => 'outgoing-welcome-leadback')
  end
end
