class RegisterController < ApplicationController
  def status
    @status = %x( sudo  asterisk -rx 'sip show registry' )
  end

  def reload
    %x( sudo asterisk -rx 'core reload' )
    respond_to do |format|
	format.html { redirect_to register_url, notice: "Перегрузка регистрации успешно пройдена!" }
    end
  end
end
