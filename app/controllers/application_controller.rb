class ApplicationController < ActionController::Base 
  protect_from_forgery with: :exception
  include SessionsHelper

  include CabinetHelper
 
  before_action :require_login


  private
 
  def require_login
    unless logged_in?
      flash[:danger] = "Вы должны ввести пароль для входа"
      redirect_to login_path # прерывает цикл запроса
    end
  end

end
