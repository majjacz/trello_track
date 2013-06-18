module Api
  class TimerController < ApplicationController

    skip_before_filter :verify_authenticity_token
    before_filter :authentificate
    respond_to :json

    def in_progress
      @task = @user.unfinished_task
      render :template => 'api/timer/task'
    end

    def last_task
      @task = @user.tasks.last
      render :template => 'api/timer/task'
    end

    def create
      if @task = Task.start(@user, params[:name], params[:board_id], params[:card_id])
        render json: {:status => true}
      else
        render json: {:status => false}
      end
    end

    def stop
      task = @user.unfinished_task
      unless task.nil?
        task.stop
        render json: {:status => true}
      else
        render json: {:status => false}
      end
    end

    def continue
      if @user.unfinished_task.nil?
        task = @user.tasks.last
        unless task.nil?
          task.continue
          render json: {:status => true}
        end
      else
        render json: {:status => false}
      end
    end

    private
    def authentificate
      @user = User.from_api_key(params[:apikey])
      head :unauthorized unless @user
    end

  end
end
