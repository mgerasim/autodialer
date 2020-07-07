namespace :google do
  desc "TODO"
  task :speech, [:record] => :environment  do |t, args|
    

      audio_file_path = args.record

      require "google/cloud/speech"

      speech = Google::Cloud::Speech.new
    
    audio_file = File.binread audio_file_path
      config     = { encoding:          :LINEAR16,
                 sample_rate_hertz: 8000,
                 language_code:     "ru-RU"   }
      audio      = { content: audio_file }

      response = speech.recognize config, audio

      results = response.results

      alternatives = results.first.alternatives
      alternatives.each do |alternative|
        answer = alternative.transcript
      
        if answer.include? "да"
           puts "1"
        end

        puts answer
        
      end
  
  end

end
