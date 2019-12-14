class Vote < ApplicationRecord
has_attached_file :record

  validates_attachment_content_type :record,
    :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]
  
                     
  validates :title, presence: true, length: { minimum: 2 }


end
