module CabinetHelper

  def cabinet_authenticate?(id, password)
    employee = Employee.find(id)
    employee != nil and employee.password == password
  end

  def cabinet_in(employee)
    session[:employee] = employee
    update_trank_callmax(1)
  end

  def cabinet_out
    session[:employee] = nil
    update_trank_callmax(2)
  end
     
  def cabineted_in?
    session[:employee] != nil
  end

  def update_trank_callmax(status)
    puts "update_trank_callmax"
    setting = Setting.first
    puts setting.is_support_call_delta
    return if setting.is_support_call_delta == false
    return if setting.call_delta == nil
    delta = setting.call_delta
    if (status != 1)
      delta = -setting.call_delta
    end
    tranks = Trank.where(:enabled => true)
    tranks.each do |trank|
      puts trank
      trank.callmax = trank.callmax + delta
      trank.save
      puts trank
    end
  end

end
