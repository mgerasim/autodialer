class CdrController < ApplicationController
  def index
    @cdr = Asteriskcdr.where("disposition = 'ANSWERED' OR lastapp = 'AppDial2'")
	respond_to do |format|
        format.html
        format.csv { send_data @cdr.to_csv, filename: "cdr-#{Date.today}.csv" }
    end

  end
end
