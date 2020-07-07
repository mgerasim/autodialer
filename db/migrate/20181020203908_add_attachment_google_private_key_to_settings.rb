class AddAttachmentGooglePrivateKeyToSettings < ActiveRecord::Migration[5.1]
  def self.up
    change_table :settings do |t|
      t.attachment :google_private_key
    end
  end

  def self.down
    remove_attachment :settings, :google_private_key
  end
end
