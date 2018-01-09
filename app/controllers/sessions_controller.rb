class SessionsController < ApplicationController
  def new
  end
  def create
 
    if authenticate?(params[:session][:password]) 
      log_in
      flash[:success] = "Добро пожаловать в систему авто обзвона!"
      redirect_to tasks_path
    else
      flash.now[:danger] = 'Не верно указан пароль' # Not quite rig
      render 'new'
    end
  end

  def destroy
 
    log_out
    redirect_to root_url
  end

end