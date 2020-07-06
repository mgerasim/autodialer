namespace :analysis do
  desc "TODO"
  task run: :environment do
    Analysis.where('created_at <= ?', 1.day.ago.to_datetime) do |analysis| 
      analysis.delete
    end 

    analysis = Analysis.new
    
    # Количество сотрудников на линии
    analysis.employee_active_count = Employee.where(:status => 1).count
    # Значение параметра в настройках - Количесов активирующих транков при входе сотрудника
    analysis.setting_trunk_active_count = Setting.first.trunk_active_count
    # Количество активных транков
    analysis.trunk_enable_count = Trank.where(:enabled => true).count
    # Количество исходящих
    analysis.outgoing_count = Outgoing.where(:status => "INSERTED")
    # Количестов откликов
    analysis.answer_count = Answer.count

    analysis.save
  end

end
