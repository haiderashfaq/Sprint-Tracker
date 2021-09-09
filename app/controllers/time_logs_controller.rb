class TimeLogsController < ApplicationController
  load_and_authorize_resource :issue, find_by: :sequence_num
  load_and_authorize_resource find_by: :sequence_num, through: :issue

  def load_issue
    @issue = Issue.find_by(sequence_num: params[:issue_id])
  end

  # GET /time_logs or /time_logs.json
  def index
    binding.pry
    @time_logs = @time_logs.paginate(page: params[:page])
    respond_to do |format|
      format.js { render js: "alert('Hi');" }
    end
  end

  # GET /time_logs/1 or /time_logs/1.json
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /time_logs/new
  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /time_logs/1/edit
  def edit
    @issue = Issue.find_by(sequence_num: params[:issue_id])
    @timelog = TimeLog.find_by(id: params[:id])
  end

  # POST /time_logs or /time_logs.json
  def create
    @time_log = TimeLog.new(time_log_params)
    @time_log.issue = Issue.find_by(sequence_num: params[:issue_id])
    @time_log.assignee_id = current_user.id

    respond_to do |format|
      if @time_log.save
        format.html { redirect_to issue_time_logs_url, notice: t('shared.success.create', resource_label: t('time_logs.timelogs_label')) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_logs/1 or /time_logs/1.json
  def update
    respond_to do |format|
      if @time_log.update(time_log_params)
        format.html { redirect_to issue_time_logs_url, notice: t('shared.success.update', resource_label: t('time_logs.timelogs_label')) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_logs/1 or /time_logs/1.json
  def destroy
    @time_log.destroy
    respond_to do |format|
      format.html { redirect_to issue_time_logs_url, alert: t('shared.success.delete', resource_label: t('time_logs.timelogs_label')) }
    end
  end

  private

    def set_time_log
      @time_log = TimeLog.find(params[:id])
    end

    def time_log_params
      params.require(:time_log).permit(:name, :date, :logged_time, :work_description)
    end
end
