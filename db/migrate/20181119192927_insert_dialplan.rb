class InsertDialplan < ActiveRecord::Migration[5.1]
  def change
    Dialplan.create(:title => 'Стандартный', :name => 'from-trunk')
    Dialplan.create(:title => 'Расширенный', :name => 'outgoing-welcome')
  end
end
