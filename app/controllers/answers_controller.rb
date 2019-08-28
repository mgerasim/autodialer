class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    date = DateTime.now
    @outgoing_total = Outgoing.where(:status => ["DIALED", "ANSWERED", "NO ANSWER", "FAILED", "BUSY", "DIALING"])

    @answer_total = Answer.all
	
    @outgoing_precent = 0 if @outgoing_total.count == 0

    @outgoing_precent = ((@answer_total.count.to_f / @outgoing_total.count.to_f) * 100).round(2) if @outgoing_total.count > 0

    @outgoing_answer_total = Answer.where(:level => ["1", "2"]) #Outgoing.where(:status => ["ANSWERED", "1", "2"])

    @outgoing_answer_precent = 0 if @outgoing_answer_total.count == 0

    @outgoing_answer_precent = ((@answer_total.count.to_f / @outgoing_answer_total.count.to_f) * 100).round(2) if @outgoing_answer_total.count > 0

    @answers = Answer.where.not(:level => 0)
    respond_to do |format|
        format.html
        format.csv { send_data @answers.to_csv, filename: "answers-#{Date.today}.csv" }
    end
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:contact)
    end
end
