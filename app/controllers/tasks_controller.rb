class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json]
  def create
    begin
      @task = Task.new(task_params)
      
      Rails.logger.error @task.csv_upload
      
      respond_to do |format|
        if @task.save
        
           @task.update(:status => 'LOADING')
    
        #  File.foreach(@task.csv_upload.path) {}
        #  count = $.
        #  @task.name = @task.name + ' ' + count.to_s        
        #  File.foreach(@task.csv_upload.path) {|line|     Rails.logger.info(line) 
        #  @contact = @task.contacts.create(phone: line, status: "INSERTED")
        #  }
          format.html { redirect_to @task, notice: 'Задание успешно создано' }
          format.json { render :show, status: :created, location: @task }
          
          TaskLoadingJob.perform_later( @task, @task.csv_upload.path)
        #       TaskDailingJob.perform_later @task 
        else
          format.html { render :new }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    rescue => ex
      Rails.logger.error "controller"
      Rails.logger.error ex.message
      Rails.logger.error ex.backtrace.join("\n")
       redirect_to @task
    end
  end


  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    
#    TaskDeleteJob.perform_later @task

    Asteriskcdr.where(:accountcode => @task.id.to_s).destroy_all

     @task.destroy


    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Процесс удаления задания запущен ....' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :csv_upload)
    end
end
