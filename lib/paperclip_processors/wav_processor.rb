module Paperclip
  class WavProcessor < Processor
    def initialize(file, options = {}, attachment = nil)
      super

      @file = file
      @attachment = attachment

      @format = options[:format] || 'wav'
      @current_format = File.extname(@file.path)
      @basename = File.basename(@file.path, @current_format)
      @params = options[:params] || '-y -i'

      @sample_rate = options[:sample_rate] || "8000"
      @bit_rate = options[:bit_rate] || "12.2k"
    end

    def make
      source = @file
      output = Tempfile.new([@basename, ".#{@format}"]) 
      begin
         parameters = [@params, ':source', '-acodec pcm_s16le -ar 8000 -ab 12.2k' , ':dest'].flatten.compact.join(' ').strip.squeeze(' ')
        Paperclip.run('ffmpeg', parameters, :source => File.expand_path(source.path), :dest => File.expand_path(output.path))
     
      rescue PaperclipCommandLineError
#        raise PaperclipError, "There was an error converting #{@basename} to .wav"
      end
      output
    end


  end
end
