require "activerecord-import/base"
ActiveRecord::Import.require_adapter('mysql2')
  
class TaskLoadingJob < ApplicationJob
  queue_as :default

  def perform(task, path)
    Rails.logger.error "TaskLoading"
#    Rails.logger.error task.csv_upload.path
    Rails.logger.error path
    
    Rails.logger.error task.status
    
    
    uploaded_file = ActionDispatch::Http::UploadedFile.new({
      :tempfile => File.new(path)
    })
    
    task.csv_upload = uploaded_file
    
    contacts = []
    File.foreach(task.csv_upload.path) {|line|     Rails.logger.info(line)
#	contact = task.contacts.create(phone: line, status: "INSERTED")
	contacts << Contact.new(task: task, phone: line, status: "INSERTED")
    } 
    
    Contact.import(contacts, validate: true)
    
    
    
    task.status = "LOADED"
    task.save
    
    Rails.logger.error task.errors.inspect
    
    TaskDailingJob.perform_later task 
    
    end
end
