module Api
  class TimerController < ApplicationController

    skip_before_filter :verify_authenticity_token
    before_filter :authentificate
    respond_to :json

    def in_progress
      @record = @user.time_records.in_progress.first
    end

    def create
      if @record = TimeRecord.start(@user, params[:name], params[:board_id], params[:card_id])
        render json: {:status => true}
      else
        render json: {:status => false}
      end
    end

    def stop
      unless @user.time_records.in_progress.empty?
        TimeRecord.find(@user.time_records.in_progress.first.id).stop
        render json: {:status => true}
      else
        render json: {:status => false}
      end
    end

    def pause
      unless @user.time_records.in_progress.empty?
        TimeRecord.find(@user.time_records.in_progress.first.id).pause
        render json: {:status => true}
      else
        render json: {:status => false}
      end
    end

    def continue_from_pause
      unless @user.time_records.in_progress.empty?
        TimeRecord.find(@user.time_records.in_progress.first.id).continue_from_pause
        render json: {:status => true}
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
