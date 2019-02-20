class SessionsController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create, :destroy]
  def new
    unless Setting.first
      Setting.new.save
    end
    if logged_in?
      redirect_to outgoings_path
    end
  end
  def create
 
    if authenticate?(params[:session][:password]) 
      log_in
      flash[:success] = "Добро пожаловать в систему автообзвона!"
      redirect_to outgoings_path
    else
      flash.now[:danger] = 'Не верно указан пароль' # Not quite rig
      render 'new'
    end
  end

  def destroy
 
    log_out

    cabinet_out

    redirect_to root_url
  end

end
