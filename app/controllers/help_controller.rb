class HelpController < ApplicationController
  def cdr
    send_file(
        "/var/log/asterisk/cdr-csv/Master.csv",
        filename: "Master.csv",
        type: "text/csv"
    )
  end
  def outgoing_destroy_all
    OutgoingDestroyAllJob.perform_later( )
    respond_to do |format|
      format.html { redirect_to outgoings_url, notice: 'Outgoing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
