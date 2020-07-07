class TaskDeleteJob < ApplicationJob
  queue_as :default

  def perform(task)

      Asteriskcdr.where(:accountcode => task.id.to_s).destroy_all

     task.destroy
    

  end

end
