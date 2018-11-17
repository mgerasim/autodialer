class Vote < ApplicationRecord
  has_attached_file :record,
			:styles => lambda { |attachment|
				{
					wav: { :processors => [:wav_processor] }
				}
			}
                        
  validates_attachment_content_type :record, content_type: /\.*\/.*\z/
  validates :title, presence: true, length: { minimum: 2 }
end
