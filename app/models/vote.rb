class Vote < ApplicationRecord
after_commit :rename_wav  
has_attached_file :record,
			:styles => lambda { |attachment|
				{
					wav: { :processors => [:wav_processor] }
				}
			}
                        
  validates_attachment_content_type :record, content_type: /\.*\/.*\z/
  validates :title, presence: true, length: { minimum: 2 }

   private
    
    def rename_wav
      puts 'rename_wav'
      Rails.logger.debug 'rename'
      File.rename(self.record.path(:wav), self.record.path(:wav).chomp('.mp3') + '.wav')
      return true
    end

end
