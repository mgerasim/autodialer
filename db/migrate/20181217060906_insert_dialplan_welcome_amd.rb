class InsertDialplanWelcomeAmd < ActiveRecord::Migration[5.1]
  def change
    Dialplan.create(:title => 'Расширенный c определением автоответчика', :name => 'outgoing-welcome-amd')
  end
end
