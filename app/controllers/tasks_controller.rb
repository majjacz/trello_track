class TasksController < ApplicationController
  before_action :set_task, only: [:stop, :continue, :edit, :update, :destroy]

  def new
    @task = Task.new
    @time_record = TimeRecord.new
  end

  def edit
  end

  def stop
    @task.stop
    redirect_to last_reporting_url, notice: 'Timer was stopped.'
  end

  def continue
    @task.continue
    redirect_to last_reporting_url, notice: 'Timer started.'
  end

  def create
    start_time = Time.zone.parse("#{params[:time_record][:start_date]} #{params[:time_record][:start_time]}")
    seconds = seconds_from_human(params[:task][:duration])
    @task = Task.new(task_params)
    @task.project = Project.find_or_create_by_name("No project")
    @task.user = current_user
    if @task.save and @task.update_time_records(task_params[:name], start_time, seconds)
      @task.reload
      end_time = @task.end_time
      redirect_to custom_url(year_from: start_time.year,
                             month_from: start_time.month,
                             day_from: start_time.day,
                             year_to: end_time.year,
                             month_to: end_time.month,
                             day_to: end_time.day
                             ), notice: 'Task created.'
    else
      render action: 'new'
    end
  end

  def update
    start_time = Time.zone.parse("#{params[:time_record][:start_date]} #{params[:time_record][:start_time]}")
    seconds = seconds_from_human(params[:task][:duration])
    if seconds != @task.total_time or start_time != @task.start_time
      if @task.update_time_records(task_params[:name], start_time, seconds)
        redirect_to last_reporting_url, notice: 'Task was successfully updated.'
      else
        render action: 'edit'
      end
    else
      if @task.update(params.require(:task).permit(:name))
        redirect_to last_reporting_url, notice: 'Task was successfully updated.'
      else
        render action: 'edit'
      end
    end
  end

  def destroy
    @task.destroy
    redirect_to last_reporting_url, notice: 'Task was destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :project)
    end
end
