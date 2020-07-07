class CdrController < ApplicationController
  def index
    @billsec_total = Asteriskcdr.sum(:billsec)
    @cdr = Asteriskcdr.where("disposition = 'ANSWERED' OR lastapp = 'AppDial2'").limit(50)
	respond_to do |format|
        format.html
        format.csv { send_data Asteriskcdr.where("disposition = 'ANSWERED' OR lastapp = 'AppDial2'").to_csv, filename: "cdr-#{Date.today}.csv" }
    end

  end
end
