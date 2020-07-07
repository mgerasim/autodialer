class InsertDialplanGoogleSpeech < ActiveRecord::Migration[5.1]
  def change
    Dialplan.create(:title => 'Расширенный c голосовым подтверждением', :name => 'outgoing-welcome-google-speech')
  end
end
