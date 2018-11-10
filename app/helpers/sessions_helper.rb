module SessionsHelper
  def authenticate?(string)
    
    config = Config.first
    is_admin = Digest::MD5::hexdigest(string) == "db9c14bbce633ead62ff7163c121f819"
    session[:is_admin] = is_admin    

    is_admin or Digest::MD5::hexdigest(string) == config.password_encrypted

  end

  def log_in
    session[:logged_in] = true
  end

  def log_out
    session[:logged_in] = false
    session[:is_admin] = false
  end

  def logged_in?
    session[:logged_in]
  end

  def is_admin?
    session[:is_admin]
  end
end
