class InsertDialplanSelectionLead < ActiveRecord::Migration[5.1]
  def change
    Dialplan.create(:title => 'Расширенный c подбором лидов', :name => 'outgoing-welcome-selection-lead')
  end
end
